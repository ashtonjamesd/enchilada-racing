internal abstract class Program {
    static void Main() {
        var source = File.ReadAllText("example/mermaid.txt");

        var transpiler = new Transpiler();
        transpiler.Generate(source);
    }
}