using System.Text.Json;

internal class EnchiladaController {
    public List<EnchiladaRacer> GetRacers() {
        var racers = GetJsonData<List<EnchiladaRacer>>("data\\racers.json");
        if (racers is null) {
            Console.WriteLine("Error deserializing racers from /data.");
            return [];
        }

        return racers;
    }

    public static T GetJsonData<T>(string path) {
        var json = File.ReadAllText(path);

        var data = JsonSerializer.Deserialize<T>(json);
        return data ?? default!;
    }
}