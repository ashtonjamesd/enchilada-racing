using System.Text.Json;

internal class DataService {
    public List<EnchiladaRacer> GetRacers() {
        var racers = GetJsonData<List<EnchiladaRacer>>("racers.json");
        if (racers is null) {
            Console.WriteLine("Error deserializing racers from /data.");
            return [];
        }

        return racers;
    }

    public EnchiladaRacer? GetRacer(int id) {
        return GetRacers().FirstOrDefault(x => x.Id == id);
    }

    public List<EnchiladaTournament> GetTournaments() {
        var tournaments = GetJsonData<List<EnchiladaTournament>>("tournaments.json");
        return tournaments;
    }

    public void SetTournaments(List<EnchiladaTournament> tournaments) {
        WriteJsonData(tournaments, "tournaments.json");
    }

    public List<EnchiladaRace> GetRaces() {
        var races = GetJsonData<List<EnchiladaRace>>("races.json");
        return races;
    }

    public void SetRaces(List<EnchiladaRace> races) {
        WriteJsonData(races, "races.json");
    }
        
    private static void WriteJsonData<T>(T value, string path) {
        var json = JsonSerializer.Serialize(value, new JsonSerializerOptions {
            WriteIndented = true
        });

        File.WriteAllText($"data\\{path}", json);
    }

    private static T GetJsonData<T>(string path) {
        var json = File.ReadAllText($"data\\{path}");

        var data = JsonSerializer.Deserialize<T>(json);
        return data ?? default!;
    }
}