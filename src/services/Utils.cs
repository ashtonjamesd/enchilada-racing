internal static class Utils {
    internal static void ReadKey(string message) {
        Console.WriteLine(message);
        Console.WriteLine("    Press enter to continue.");
        Console.ReadKey();
    }

    internal static string GetInput(string message) {
        while (true) {
            Console.Write(message);
            var input = Console.ReadLine();

            if (input is null or "") {
                continue;
            }

            return input;
        }
    }

    internal static bool GetInputChoice(string message) {
        while (true) {
            Console.Write($"{message} (y/n): ");
            var input = Console.ReadLine();

            if (input is not ("y" or "n")) {
                continue;
            }

            return input is "y";
        }
    }

    internal static T GetItemChoice<T>(List<T> items, string header) {
        int idx = 0;

        while (true) {
            Console.Clear();
            Console.WriteLine($"{header}\n");

            for (int i = 0; i < items.Count; i++) {
                Console.WriteLine(idx == i ? $"> {items[i]}" : items[i]);
            }

            var input = Console.ReadKey();
            if (input.Key is ConsoleKey.UpArrow) {
                if (idx > 0) idx--;
            } 
            else if (input.Key is ConsoleKey.DownArrow) {
                if (idx < items.Count - 1) idx++;
            } 
            else if (input.Key is ConsoleKey.Enter) {
                return items[idx];
            }
        }
    }
}