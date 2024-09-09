public sealed class Transpiler {
    public List<Expression> Expressions { get; set; } = new();

    public void Generate(string source) {
        var lexer = new Lexer(source);
        var tokens = lexer.Tokenize();
        // lexer.Print();

        var parser = new Parser(tokens);
        Expressions = parser.Parse();
        parser.Print();


        if (!Directory.Exists("out"))
            Directory.CreateDirectory("out");

        foreach (var expr in Expressions){
            if (expr is ClassDeclaration) {
                GenerateClassDeclaration();
            }
        }
    }

    private void GenerateClassDeclaration() {
        
    }
}
