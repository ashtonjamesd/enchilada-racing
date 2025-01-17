using System.Text.Json.Serialization;

internal class EnchiladaMemo {
    [JsonPropertyName("author")]
    public string Author { get; set; }

    [JsonPropertyName("description")]
    public string Description { get; set; }
    
    [JsonPropertyName("dateCreated")]
    public DateTime DateCreated { get; set; }
}