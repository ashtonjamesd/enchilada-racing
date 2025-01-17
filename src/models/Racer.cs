using System.Text.Json.Serialization;

internal class EnchiladaRacer()
{
    [JsonPropertyName("racerId")]
    public int Id { get; set; }

    [JsonPropertyName("racerName")]
    public string Name { get; set; }

    [JsonPropertyName("nickName")]
    public string NickName { get; set; }
}