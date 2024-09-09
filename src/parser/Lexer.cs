sealed class Lexer {
    public string Source { get; set; }
    public int Current { get; set; }
    public List<Token> Tokens { get; set; } = new();

    public Lexer(string source) {
        Source = source;
    }

    private Dictionary<string, TokenType> Keywords = new() {
        {"class", TokenType.CLASS},
    };

    public List<Token> Tokenize() {
        while (!IsEof()) {
            if (char.IsWhiteSpace(Source[Current]) || Source[Current] == '\n') {
                Current++;
                continue;
            }

            Tokens.Add(Next());
            Current++;
        }
        
        Tokens.Add(new("", TokenType.EOF));
        return Tokens;
    }

    private Token Next() {
        char curr = Source[Current];

        return Source[Current] switch {
            char c when char.IsLetter(c) => CreateIdentifier(),

            ':'  => new(curr, TokenType.COLON),
            '('  => new(curr, TokenType.LPAREN),
            ')'  => new(curr, TokenType.RPAREN),
            '{'  => new(curr, TokenType.LBRACE),
            '}'  => new(curr, TokenType.RBRACE),
            '+'  => new(curr, TokenType.PLUS),
            '-'  => new(curr, TokenType.MINUS),
            '|'  => new(curr, TokenType.PIPE),
            '\"' => new(curr, TokenType.SPEECH),
            '~' => new(curr, TokenType.TILDE),
            '#' => new(curr, TokenType.HASHTAG),
            '*' => new(curr, TokenType.ASTERISK),
            '$' => new(curr, TokenType.DOLLAR),

            _ => new("", TokenType.BAD),
        };
    }

    private Token CreateIdentifier() {
        int start = Current;

        while (!IsEof() && char.IsLetter(Source[Current]) || Source[Current] == '_')
            Current++;

        Current--;
        var identifier = Source[start..(Current + 1)];

        if (Keywords.TryGetValue(identifier, out TokenType type))
            return new(identifier, type);

        return new(identifier, TokenType.IDENTIFIER);
    }

    private bool IsEof() {
        return Current >= Source.Length;
    }

    public void Print() {
        foreach (var token in Tokens) {
            Console.WriteLine(token.ToString());
        }
    }
}