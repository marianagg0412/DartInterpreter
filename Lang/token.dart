enum TokenType{
  ASSIGN,
  COMMA,
  PERIODT,
  DIV,
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
  NOE_,
  NOT,
  PLUS,
  SEMICOLON
 
}

class Token{
  TokenType token_type;
  String literal;
  Token(this.token_type,this.literal);


  String toString(){

    return (this.token_type.name+':'+this.literal);

  }


  TokenType? look_up_token_type(String token_type){

     var keywords ={
        '=':TokenType.ASSIGN,
        ',':TokenType.COMMA,
        '.':TokenType.PERIODT,
        '/':TokenType.DIV,
        'false':TokenType.FALSE,
        'true':TokenType.TRUE,
        'if':TokenType.IF,
        'else':TokenType.ELSE,
        'let':TokenType.LET,
        'function':TokenType.FUNCTION,
        'return':TokenType.RETURN,
        'EOF':TokenType.EOF,
        '==':TokenType.EQ,
        '>':TokenType.GT,
        '>=':TokenType.GTE,
        'ident':TokenType.IDENT,
        '?':TokenType.ILLEGAL,
        'int':TokenType.INT,
        '<':TokenType.LT,
        '<=':TokenType.LTE
     };

     
    
     return keywords.containsKey(token_type)
      ? keywords[token_type]: TokenType.IDENT;

  }
 
}