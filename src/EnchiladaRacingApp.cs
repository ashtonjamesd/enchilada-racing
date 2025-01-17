using System.Security.Cryptography;

namespace enchilada_racing.src;

class EnchiladaRacingApp {
    private readonly EnchiladaController Controller = new();
    private static Dictionary<string, Func<bool>> Options = [];

    public EnchiladaRacingApp() {
        Options = new Dictionary<string, Func<bool>> {
            { "Add Race", () => Controller.AddEnchiladaRace() },
            { "Add Tournament", () => Controller.AddEnchiladaTournament() },
            { "View Records", () => Controller.ViewRecords() }
        };
    }

    public void Run() {
        for (;;) {
            var choice = Utils.GetItemChoice(Options.Keys.ToList(), $" -- {Constants.AppName} -- \n");
           
            var action = Options[choice];
            action();
        }
    }
}