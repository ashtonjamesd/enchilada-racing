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

        var participatingRacers = GetRacersForTournament(selectedTournament!);

        var races = data.GetRaces();
        var tournamentRaces = GetRacesForTournament(selectedTournament!);

        List<EnchiladaRaceEntry> entries = [];
        foreach (var racer in participatingRacers) {
            Console.Clear();
            Console.WriteLine($"For Racer: {racer.Name}\n");

            var raceTime = Utils.GetInput("Enter time (mm:ss:sss): ");
            var isKnockout = Utils.GetInputChoice("Is knockout?");

            var entry = raceEntryFactory.Create(racer.Id, raceTime, isKnockout);
            entries.Add(entry);
        }

        var id = races.Count != 0 ? races.Max(x => x.Id) + 1 : 0;
        var raceNum = tournamentRaces.Count != 0 ? tournamentRaces.Max(x => x.RaceNumber) + 1 : 1;
        var newRace = raceFactory.Create(selectedTournament!.Id, entries, id, raceNum);

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

        return races;
    }

    internal bool AddEnchiladaTournament() {
        Console.Clear();
        var tournamentName = Utils.GetInput("Enter tournament name: ");

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
            RacerIds = [.. selectedRacers.Select(x => x.Id)],
            Name = tournamentName,
            Id = tournaments.Count != 0 ? tournaments.Max(x => x.Id) + 1 : 0
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
            Console.Write($"\nRace: {race.RaceNumber}");
            
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

    internal bool ViewRacers() {
        Console.Clear();
        Console.WriteLine("Enchilada Racers\n");

        var racers = data.GetRacers();
        foreach (var racer in racers) {
            Console.WriteLine($"{racer.Id}: {racer.Name}");
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
            Console.WriteLine($"\n{tournament.Name}");

            foreach (var racer in racers) {
                Console.WriteLine($"  {racer.Id}: {racer.Name}");
            }
        }

        Utils.ReadKey("");
        return true;
    }
}