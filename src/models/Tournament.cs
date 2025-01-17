using System.Text.Json.Serialization;

internal class EnchiladaTournament {
    
    [JsonPropertyName("tournamentId")]
    public int Id { get; set; }

    [JsonPropertyName("dateStarted")]
    public DateTime DateStarted { get; set; }

    [JsonPropertyName("racers")]
    public List<int> RacerIds { get; set; } = [];

    [JsonPropertyName("tournamentName")]
    public string Name { get; set; }
}