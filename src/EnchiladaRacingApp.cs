using System.Security.Cryptography;

namespace enchilada_racing.src;

class EnchiladaRacingApp {
    private readonly EnchiladaController Controller = new();
    private static Dictionary<string, Func<bool>> Options = [];

    public EnchiladaRacingApp() {
        Options = new Dictionary<string, Func<bool>> {
            { "Add Race",         Controller.AddEnchiladaRace },
            { "Add Tournament",   Controller.AddEnchiladaTournament },
            { "View Races",       Controller.ViewRecords },
            { "View Racers",      Controller.ViewRacers },
            { "View Tournaments", Controller.ViewTournaments },
            { "View Tracks",      Controller.ViewTracks },
            { "Add Memo",         Controller.AddMemo },
            { "View Memos",       Controller.ViewMemo },
            { "Quit",             () => true },
        };
    }

    public void Run() {
        for (;;) {
            var choice = Utils.GetItemChoice(Options.Keys.ToList(), $" -- {Constants.AppName} -- \n");
            if (choice is "Quit") {
                Console.WriteLine($"\nThank you for using the {Constants.AppName} application");
                break;
            }
           
            var action = Options[choice];
            action();
        }
    }
}