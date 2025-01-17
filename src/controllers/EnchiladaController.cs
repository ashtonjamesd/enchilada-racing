internal class EnchiladaController {
    private readonly DataService data = new();

    internal bool AddEnchiladaRace() {
        Console.Clear();
        var tournaments = data.GetTournaments();

        if (tournaments.Count == 0) {
            Console.WriteLine("No tournaments to add race to. Create a tournament first.");
            Utils.ReadKey();
            return false;
        }

        var tournamentNames = tournaments.Select(x => x.Name).ToList();
        var selectedTournamentName = Utils.GetItemChoice(tournamentNames, "Select tournament for this race:");
        var selectedTournament = tournaments.FirstOrDefault(x => x.Name == selectedTournamentName);

        var racers = data.GetRacers();
        var participatingRacers = racers
            .Where(racer => selectedTournament!.RacerIds.Contains(racer.Id))
            .ToList();

        var races = data.GetRaces();
        var tournamentRaces = races
            .Where(x => x.TournamentId == selectedTournament!.Id)
            .ToList();

        List<EnchiladaRaceEntry> entries = [];
        foreach (var racer in participatingRacers) {
            Console.Clear();
            Console.WriteLine($"For Racer: {racer.Name}\n");

            var raceTime = Utils.GetInput("Enter time (mm:ss:sss): ");
            var isKnockout = Utils.GetInputChoice("Is knockout?");

            var entry = new EnchiladaRaceEntry() {
                RacerId = racer.Id,
                raceTime = raceTime,
                IsKnockout = isKnockout,
            };

            entries.Add(entry);
        }

        races.Add(new() {
            TournamentId = selectedTournament!.Id,
            RaceEntries = entries,
            Id = races.Count != 0 ? races.Max(x => x.Id) + 1 : 0,
            RaceNum = tournamentRaces.Count != 0 ? tournamentRaces.Max(x => x.RaceNum) + 1 : 1
        });

        data.SetRaces(races);

        Console.Clear();
        Console.WriteLine($"Added race entry to tournament '{selectedTournamentName}'.");
        Utils.ReadKey();

        return true;
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

        Console.WriteLine($"\nAdded tournament: {tournamentName}");
        Utils.ReadKey();

        return true;
    }

    internal bool ViewRecords() {
        Console.Clear();
        var tournaments = data.GetTournaments();

        if (tournaments.Count == 0) {
            Console.WriteLine("No tournaments to add race to. Create a tournament first.");
            Utils.ReadKey();
            return false;
        }

        var tournamentNames = tournaments.Select(x => x.Name).ToList();
        var selectedTournamentName = Utils.GetItemChoice(tournamentNames, "Select tournament to view:");
        var selectedTournament  = tournaments.FirstOrDefault(x => x.Name == selectedTournamentName);

        var races = data.GetRaces()
            .Where(x => x.TournamentId == selectedTournament!.Id)
            .ToList();

        if (races is null) {
            Console.WriteLine("\nNo races are on this tournament.");
            Utils.ReadKey();
            return false;
        }

        Console.Clear();
        Console.WriteLine($"{selectedTournament!.Name}\n");
        foreach (var race in races) {
            Console.Write($"\nRace: {race.Id}");
            
            foreach (var entry in race.RaceEntries) {
                var racer = data.GetRacer(entry.RacerId);

                Console.WriteLine($"\n  {racer!.Name}");
                Console.WriteLine($"  Time: {entry.raceTime} {(entry.IsKnockout ? "#" : "")}");
            }
            Console.WriteLine();
        }

        Console.WriteLine();
        Utils.ReadKey();
        return true;
    }
}