using System.Text.Json.Serialization;

internal class EnchiladaRace {
    [JsonPropertyName("raceId")]
    public int Id { get; set; }

    [JsonPropertyName("raceNum")]
    public int RaceNum { get; set; }

    [JsonPropertyName("tournamentId")]
    public int TournamentId { get; set; }

    [JsonPropertyName("raceEntries")]
    public List<EnchiladaRaceEntry> RaceEntries { get; set; } = [];
}

internal class EnchiladaRaceEntry {
    [JsonPropertyName("racerId")]
    public int RacerId { get; set; }

    [JsonPropertyName("raceTime")]
    public string raceTime { get; set; }

    [JsonPropertyName("isKnockout")]
    public bool IsKnockout { get; set; }
}