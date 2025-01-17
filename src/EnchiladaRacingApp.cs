namespace enchilada_racing.src;

class EnchiladaRacingApp {
    private readonly EnchiladaController controller = new();

    public void Run() {
        for (;;) {
            Console.WriteLine($" -- {Constants.AppName} -- \n");

            var racers = controller.GetRacers();

            foreach (var racer in racers) {
                Console.WriteLine($"{racer.Id} : {racer.Name}");
            }

            Console.ReadKey();
        }
    }
}