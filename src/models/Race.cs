using System.Text.Json.Serialization;

internal class EnchiladaRace {
    [JsonPropertyName("raceId")]
    public int Id { get; set; }

    [JsonPropertyName("raceNum")]
    public int RaceNumber { get; set; }

    [JsonPropertyName("tournamentId")]
    public int TournamentId { get; set; }

    [JsonPropertyName("trackId")]
    public int TrackId { get; set; }

    [JsonPropertyName("raceEntries")]
    public List<EnchiladaRaceEntry> RaceEntries { get; set; } = [];
}

internal class EnchiladaRaceEntry {
    [JsonPropertyName("racerId")]
    public int RacerId { get; set; }

    [JsonPropertyName("raceTime")]
    public string RaceTime { get; set; }

    [JsonPropertyName("isKnockout")]
    public bool IsKnockout { get; set; }
}