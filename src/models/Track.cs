using System.Text.Json.Serialization;

internal class EnchiladaTrack {
    [JsonPropertyName("trackId")]
    public int Id { get; set; }

    [JsonPropertyName("trackDescription")]
    public string TrackDescription { get; set; }
}