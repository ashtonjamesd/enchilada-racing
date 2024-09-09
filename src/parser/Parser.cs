using System.ComponentModel;

class Parser {
    public List<Token> Tokens { get; set; }
    public int Current { get; set; }
    public List<Expression> Expressions { get; set; } = new();

    public Parser(List<Token> tokens) {
        Tokens = tokens;
    }

    public List<Expression> Parse() {
        while (Tokens[Current].Type != TokenType.EOF) {
            var expr = Tokens[Current].Type switch {
                TokenType.CLASS => ParseClassExpr(),
                _ => throw new Exception($"Unexpected token found while parsing: {Tokens[Current].Lexeme}"),
            };

            Expressions.Add(expr);
        }

        return Expressions;
    }

    public Expression ParseClassExpr() {
        Expect(TokenType.CLASS);

        var identifier = Tokens[Current].Lexeme;
        Current++;
        
        if (!Match(TokenType.LBRACE))
            return new ClassDeclaration(identifier, new List<MemberExpr>());

        if (Match(TokenType.RBRACE))
            return new ClassDeclaration(identifier, new List<MemberExpr>());

        var members = new List<MemberExpr>();
        while (Tokens[Current].Type != TokenType.RBRACE) {
            members.Add(ParseMember());
        }

        Expect(TokenType.RBRACE);
        return new ClassDeclaration(identifier, members);
    }

private MemberExpr ParseMember() {
    // Consume access modifier, type, and identifier in order
    var accessModifier = Consume().Lexeme;
    var type = Consume().Lexeme;
    var identifier = Consume().Lexeme;

    if (Match(TokenType.LPAREN)) {

        var parameters = new List<ParameterExpr>();

        while (!Match(TokenType.RPAREN)) {
            var parameterName = Consume().Lexeme;
            parameters.Add(new ParameterExpr(parameterName));

            if (Match(TokenType.COMMA)) {}
        }

        Consume();

        string returnType = "void";
        if (Match(TokenType.IDENTIFIER)) {
            returnType = Consume().Lexeme;
        }

        return new MethodExpr(accessModifier, identifier, returnType, parameters);
    } 

    return new PropertyExpr(accessModifier, identifier, type);
}


    private Token Consume() {
        Current++;
        return Tokens[Current - 1];
    }

    private void Expect(TokenType type) {
        if (Tokens[Current].Type != type)
            throw new Exception($"Expected '{type}', got: '{Tokens[Current].Type}'");

        Current++;
    }

    private bool Match(TokenType type) {
        if (Tokens[Current].Type == type) {
            Current++;
            return true;
        }

        return false;
    }

    public void Print() {
        foreach (var expr in Expressions) {
            Console.Write(expr.ToString());
        }
    }
}