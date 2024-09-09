using System.Diagnostics.CodeAnalysis;

public abstract class Expression {}

public sealed class ClassDeclaration : Expression {
    public string Identifier { get; set; }
    public List<MemberExpr> Members { get; set; }

    public ClassDeclaration(string identifier, List<MemberExpr> members) {
        Identifier = identifier;
        Members = members;
    }

    public override string ToString() {
        var formattedMembers = string.Join("\n    ", Members.Select(m => m.ToString()));
        return $"{Identifier} {{\n    {formattedMembers}\n}}";
    }
}


public abstract class MemberExpr : Expression {
    public string AccessModifier { get; set; }
    public string Identifier { get; set; }

    public MemberExpr(string accessModifier, string identifier) {
        AccessModifier = accessModifier;
        Identifier = identifier;
    }
}

public sealed class PropertyExpr : MemberExpr {
    public string Type { get; set; }

    public PropertyExpr(string accessModifier, string identifier, string type) : base(accessModifier, identifier) {
        Type = type;
    }

    public override string ToString()
        => $"{AccessModifier} {Type} {Identifier}";
}

public sealed class MethodExpr : MemberExpr {
    public string ReturnType { get; set; }
    public List<ParameterExpr> Parameters { get; set; }
    
    public MethodExpr(string accessModifier, string identifier, string returnType, List<ParameterExpr> parameters)
        : base(accessModifier, identifier) {
        ReturnType = returnType;
        Parameters = parameters;
    }
}

public sealed class ParameterExpr : Expression {
    public string Type { get; set; }

    public ParameterExpr(string type) {
        Type = type;
    }
}