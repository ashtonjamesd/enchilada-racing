public enum TokenType {
    IDENTIFIER, CLASS,
    COLON, PLUS, MINUS, GTHAN, LTHAN, PIPE, LPAREN, RPAREN, LBRACE, RBRACE, SPEECH, 
    TILDE, HASHTAG, ASTERISK, DOLLAR, COMMA,
    BAD, EOF
}

sealed class Token {
    public string Lexeme { get; set; }

    public TokenType Type { get; set; }

    public Token(string lexeme, TokenType type) {
        Lexeme = lexeme;
        Type = type;
    }

    public Token(char lexeme, TokenType type) {
        Lexeme = lexeme.ToString();
        Type = type;
    }

    public override string ToString()
        => $"{Type} ({Lexeme})";
}