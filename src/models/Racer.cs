using System.Text.Json.Serialization;

internal class EnchiladaRacer(string name, string id)
{
    [JsonPropertyName("racerId")]
    public string Id { get; set; } = id;
    
    [JsonPropertyName("racerName")]
    public string Name { get; set; } = name;
}