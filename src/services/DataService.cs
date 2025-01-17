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

    public EnchiladaTrack? GetTrack(int id) {
        return GetTracks().FirstOrDefault(x => x.Id == id);
    }

    public List<EnchiladaTournament> GetTournaments() {
        return GetJsonData<List<EnchiladaTournament>>("tournaments.json");;
    }

    public void SetTournaments(List<EnchiladaTournament> tournaments) {
        WriteJsonData(tournaments, "tournaments.json");
    }

    public List<EnchiladaRace> GetRaces() {
        return GetJsonData<List<EnchiladaRace>>("races.json");;
    }

    public void SetRaces(List<EnchiladaRace> races) {
        WriteJsonData(races, "races.json");
    }

    public List<EnchiladaTrack> GetTracks() {
        return GetJsonData<List<EnchiladaTrack>>("tracks.json");;
    }

    public void SetTracks(List<EnchiladaTrack> tracks) {
        WriteJsonData(tracks, "tracks.json");
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