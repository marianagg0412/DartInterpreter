enum TokenType{
    ASSIGN,
    COMMA, 
    DOT,
    FALSE,
    TRUE,
    IF,
    ELSE,
    FUNCTION,
    RETURN,
    EOF,
    EQ,
    GT,
    GTE,
    IDENT,
    LET,
    ILLEGAL,
    INT,
    LT,
    LTE,
    NOT,
    NOTQ,
    PLUS,
    SEMICOLON,
    L_PAREN,
    R_PAREN,
    L_BRACE,
    R_BRACE,
    MINUS,
    DIVISION,
    MULTIPLICATION,
    L_BRACKET,
    R_BRACKET
}

class Token{
  TokenType tokenType;
  String literal;
  Token({required this.tokenType, required this.literal});

  @override
  String toString() => '${tokenType.name}:$literal';


  static TokenType lookUpTokenType(String tokenType){

     const keywords = {
    'false': TokenType.FALSE,
    'true': TokenType.TRUE,
    'if': TokenType.IF,
    'else': TokenType.ELSE,
    'let': TokenType.LET,
    'function': TokenType.FUNCTION,
    'return': TokenType.RETURN,
    'EOF': TokenType.EOF,
    'ident': TokenType.IDENT,
    'int': TokenType.INT,
  };
    
    return keywords[tokenType] ?? TokenType.IDENT;
  }
 
}