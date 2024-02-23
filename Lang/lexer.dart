import 'token.dart';

class Lexer{
  final String source;
  int position = 0;
  String currentChar = '';

  Lexer({required this.source}){
    _readChar();
  }
  void _readChar(){
    if(position >= source.length){
      currentChar = '\0';
    }else{
      currentChar = source[position];
    }
    position++;
  }
  String _peekChar(){
    if(position >= source.length){
      return '\0';
    }else{
      return source[position];
    }
  }

  void _skipWhiteSpace() {
  while (currentChar.contains(RegExp(r'\s')) && position < source.length) {
    _readChar();
  }
}

  bool _isLetter(String char){
    return char.contains(RegExp(r'[a-zA-Z_]'));
  }

  bool _isDigit(String char){
    return char.contains(RegExp(r'[0-9]'));
  }

  String readIdentifier(){
    final pos = position;
    while(_isLetter(currentChar) || _isDigit(currentChar)){
      _readChar();
    }
    return source.substring(pos, position);
  }

  String readNumber(){
    final pos = position;
    while(_isDigit(currentChar)){
      _readChar();
    }
    return source.substring(pos, position);
  }

  Token nextToken(){
    _skipWhiteSpace();
    Token? token;
    if(currentChar == '='){
      if(_peekChar() == '='){
        final char = currentChar;
        _readChar();
        token = Token(tokenType: TokenType.EQ, literal: char + currentChar);
      }else{
        final char = currentChar;
        _readChar();
        token = Token(tokenType: TokenType.ASSIGN, literal: char);
      }
    }else if(currentChar == '+'){
      token = Token(tokenType: TokenType.PLUS, literal: currentChar);
    }else if(currentChar == '-'){
      token = Token(tokenType: TokenType.MINUS, literal: currentChar);
    }else if(currentChar == '/'){
      token = Token(tokenType: TokenType.DIVISION, literal: currentChar);
    }else if(currentChar == '*'){
      token = Token(tokenType: TokenType.MULTIPLICATION, literal: currentChar);
    }else if(currentChar == '('){
      token = Token(tokenType: TokenType.L_PAREN, literal: currentChar);
    }else if(currentChar == ')'){ 
      token = Token(tokenType: TokenType.R_PAREN, literal: currentChar);
    }else if(currentChar == '{'){
      token = Token(tokenType: TokenType.L_BRACE, literal: currentChar);
    }else if(currentChar == '}'){
      token = Token(tokenType: TokenType.R_BRACE, literal: currentChar);
    }else if(currentChar == '['){
      token = Token(tokenType: TokenType.L_BRACKET, literal: currentChar);
    }else if(currentChar == ']'){
      token = Token(tokenType: TokenType.R_BRACKET, literal: currentChar);
    }else if(currentChar == ','){
      token = Token(tokenType: TokenType.COMMA, literal: currentChar);
    }else if(currentChar == ';'){
      token = Token(tokenType: TokenType.SEMICOLON, literal: currentChar);
    }else if(currentChar == '.'){
      token = Token(tokenType: TokenType.DOT, literal: currentChar);
    }else if(currentChar == '>'){
      if(_peekChar() == '='){
        final char = currentChar;
        _readChar();
        token = Token(tokenType: TokenType.GTE, literal: char + currentChar);
      }else{
        token = Token(tokenType: TokenType.GT, literal: currentChar);
      }
    }else if(currentChar == '<'){
      if(_peekChar() == '='){
        final char = currentChar;
        _readChar();
        token = Token(tokenType: TokenType.LTE, literal: char + currentChar);
      }else{
        token = Token(tokenType: TokenType.LT, literal: currentChar);
      }
    }else if(currentChar == '!'){
      if(_peekChar() == '='){
        final char = currentChar;
        _readChar();
        token = Token(tokenType: TokenType.NOTQ, literal: char + currentChar);
      }else{
        token = Token(tokenType: TokenType.NOT, literal: currentChar);
      }
    }else{
      token = Token(tokenType: TokenType.ILLEGAL, literal: currentChar);
    }
    _readChar();
    return token;
    }
}