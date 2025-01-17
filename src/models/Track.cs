using System.Text.Json.Serialization;

internal class EnchiladaTrack {
    [JsonPropertyName("trackId")]
    public int Id { get; set; }

    [JsonPropertyName("trackName")]
    public string Name { get; set; }

    [JsonPropertyName("trackDescription")]
    public string Desc { get; set; }
}