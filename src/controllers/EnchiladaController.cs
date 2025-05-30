internal class EnchiladaController {
    private readonly DataService data = new();

    private readonly EnchiladaRaceEntryFactory raceEntryFactory = new();
    private readonly EnchiladaRaceFactory raceFactory = new();

    internal bool AddEnchiladaRace() {
        Console.Clear();
        var tournaments = data.GetTournaments();
        if (tournaments.Count == 0) {
            Utils.ReadKey("No tournaments to add race to. Create a tournament first.");
            return false;
        }

        var tournamentNames = tournaments.Select(x => x.Name).ToList();
        var selectedTournamentName = Utils.GetItemChoice(tournamentNames, "Select tournament for this race:");
        var selectedTournament = tournaments.FirstOrDefault(x => x.Name == selectedTournamentName);

        List<EnchiladaRaceEntry> entries = [];
        var participatingRacers = GetRacersForTournament(selectedTournament!);
        
        foreach (var racer in participatingRacers) {
            Console.Clear();
            Console.WriteLine($"For Racer: {racer.Name}\n");

            var raceTime = Utils.GetInput("Enter time (mm:ss:sss): ");
            var isKnockout = Utils.GetInputChoice("Is knockout?");

            var entry = raceEntryFactory.Create(racer.Id, raceTime, isKnockout);
            entries.Add(entry);
        }

        var tracks = data.GetTracks();
        var trackNames = tracks.Select(x => x.Name).ToList();
        var choice = Utils.GetItemChoice(trackNames, "Select a track for this race");
        var selectedTrack = tracks.FirstOrDefault(x => x.Name == choice);

        var races = data.GetRaces();
        var tournamentRaces = GetRacesForTournament(selectedTournament!);

        var id = races.Count != 0 ? races.Max(x => x.Id) + 1 : 0;

        var raceNum = tournamentRaces.Count != 0 ? tournamentRaces.Max(x => x.RaceNumber) + 1 : 1;

        var newRace = raceFactory.Create(selectedTournament!.Id, entries, id, raceNum, selectedTrack!.Id);
        races.Add(newRace);

        data.SetRaces(races);

        Console.Clear();
        Utils.ReadKey($"Added race entry to tournament '{selectedTournamentName}'.");

        return true;
    }

    internal List<EnchiladaRacer> GetRacersForTournament(EnchiladaTournament tournament) {
        var racers = data.GetRacers();
        var participatingRacers = racers
            .Where(racer => tournament.RacerIds.Contains(racer.Id)).ToList();

        return participatingRacers;
    }

    internal List<EnchiladaRace> GetRacesForTournament(EnchiladaTournament tournament) {
        var races = data.GetRaces();
        var tournamentRaces = races
            .Where(x => x.TournamentId == tournament.Id).ToList();

        return tournamentRaces;
    }

    internal List<EnchiladaRaceEntry> GetRacesForRacer(int racerId) {
        var races = data.GetRaces();

        List<EnchiladaRaceEntry> entries = [];
        foreach (var race in races) {
            foreach (var entry in race.RaceEntries) {
                if (entry.RacerId == racerId) {
                    entries.Add(entry);
                }
            }
        }

        return entries;
    }

    internal bool AddEnchiladaTournament() {
        Console.Clear();
        var tournamentName = Utils.GetInput("Enter tournament name: ");
        var tournamentDesc = Utils.GetInput("Enter tournament description: ");

        var tournaments = data.GetTournaments();

        var racers = data.GetRacers();
        var racerNames = racers.Select(x => x.Name).ToList();

        List<EnchiladaRacer> selectedRacers = [];
        while (true) {
            var selectedRacer = Utils.GetItemChoice(racerNames, "Select racers in this tournament");
            var racer = racers.FirstOrDefault(x => x.Name == selectedRacer);
            selectedRacers.Add(racer!);

            var shouldContinue = Utils.GetInputChoice("\nSelect another racer?");
            if (shouldContinue) continue;
            break;
        }

        var tournament = new EnchiladaTournament() {
            Name = tournamentName,
            Desc = tournamentDesc,
            DateStarted = DateTime.Now,
            RacerIds = [.. selectedRacers.Select(x => x.Id)],
            Id = tournaments.Count != 0 ? tournaments.Max(x => x.Id) + 1 : 0,
        };

        tournaments.Add(tournament);
        data.SetTournaments(tournaments);

        Utils.ReadKey($"\nAdded tournament: {tournamentName}");
        return true;
    }

    internal bool ViewRecords() {
        Console.Clear();
        var tournaments = data.GetTournaments();

        if (tournaments.Count == 0) {
            Utils.ReadKey("No tournaments to add race to. Create a tournament first.");
            return false;
        }

        var tournamentNames = tournaments.Select(x => x.Name).ToList();
        var selectedTournamentName = Utils.GetItemChoice(tournamentNames, "Select tournament to view:");
        var selectedTournament  = tournaments.FirstOrDefault(x => x.Name == selectedTournamentName);

        var races = data.GetRaces()
            .Where(x => x.TournamentId == selectedTournament!.Id)
            .ToList();

        if (races is null) {
            Utils.ReadKey("\nNo races are on this tournament.");
            return false;
        }

        Console.Clear();
        Console.WriteLine($"{selectedTournament!.Name}\n");
        foreach (var race in races) {
            Console.Write($"\nRace:  {race.RaceNumber}");

            var track = data.GetTrack(race.TrackId);
            Console.Write($"\nTrack: {track!.Name}");
            
            foreach (var entry in race.RaceEntries) {
                var racer = data.GetRacer(entry.RacerId);

                Console.WriteLine($"\n  {racer!.Name}");
                Console.WriteLine($"  Time: {entry.RaceTime} {(entry.IsKnockout ? "#" : "")}");
            }
            Console.WriteLine();
        }

        Console.WriteLine();
        Utils.ReadKey("");
        return true;
    }

    internal double GetSecondsFromRaceTime(string raceTime) {
        var parts = raceTime.Split(":");

        var seconds = int.Parse(parts[0]);
        var milliseconds = int.Parse(parts[1]);

        return seconds + (milliseconds / 1000);
    }

    internal bool ViewRacers() {
        Console.Clear();
        Console.WriteLine("Enchilada Racers\n");

        var racers = data.GetRacers();
        foreach (var racer in racers) {
            var races = GetRacesForRacer(racer.Id);

            double bestTime = 100;
            string bestRaceTime = races.FirstOrDefault()?.RaceTime ?? "";
            foreach (var race in races) {
                var raceTime = GetSecondsFromRaceTime(race.RaceTime); 
                if (raceTime < bestTime) {
                    bestTime = raceTime;
                    bestRaceTime = race.RaceTime;
                }
            }

            Console.WriteLine($"{racer.Id}: {racer.Name} ({racer.NickName})");
            Console.WriteLine($"  Best Time: {bestRaceTime}\n");
        }

        Utils.ReadKey("");
        return true;
    }

    internal bool ViewTournaments() {
        Console.Clear();
        Console.WriteLine("Enchilada Tournaments\n");

        var tournaments = data.GetTournaments();

        foreach (var tournament in tournaments) {
            var racers = GetRacersForTournament(tournament);
            Console.WriteLine($"\n{tournament.Name} | {tournament.DateStarted.Date}");
            Console.WriteLine($"  {tournament.Desc}\n");

            foreach (var racer in racers) {
                Console.WriteLine($"  {racer.Id}: {racer.Name}");
            }
            Console.WriteLine();
        }

        Utils.ReadKey("");
        return true;
    }

    internal bool ViewTracks() {
        Console.Clear();
        Console.WriteLine("Enchilada Tracks\n");

        var tracks = data.GetTracks();

        foreach (var track in tracks) {
            Console.WriteLine($"{track.Id}: {track.Name}");
            Console.WriteLine($"  {track.Desc}\n");
        }

        Utils.ReadKey("");
        return true;
    }

    internal bool AddMemo() {
        Console.Clear();

        var memoTitle = Utils.GetInput("Enter memo title: ");
        var memoDesc = Utils.GetInput("Enter memo desc: ");
        var memoAuthor = Utils.GetInput("Who are you? (author): ");

        var memo = new EnchiladaMemo() {
            Title = memoTitle,
            Description = memoDesc,
            Author = memoAuthor,
            DateCreated = DateTime.Now
        };

        var memos = data.GetMemos();
        memos.Add(memo);
        data.SetMemos(memos);

       return true; 
    }

    internal bool ViewMemo() {
        Console.Clear();
        Console.WriteLine("Enchilada Memos:\n");
        
        var memos = data.GetMemos();

        foreach (var memo in memos) {
            Console.WriteLine($"{memo.Title}");
            Console.WriteLine($"  by {memo.Author}");

            Console.WriteLine($"\n{FormatDescription(memo.Description, 80)}");
            Console.WriteLine(new string('-', 48) + "\n");
        }

        Utils.ReadKey("");
        return true;
    }

    private static string FormatDescription(string description, int maxLength) {
        var lines = new List<string>();

        for (int i = 0; i < description.Length; i += maxLength) {
            lines.Add("  " + description.Substring(i, Math.Min(maxLength, description.Length - i)));
        }

        return string.Join("\n", lines);
    }
}