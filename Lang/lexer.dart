import 'token.dart';
class Lexer{
  final String source;
  int position = 0;
  String currentChar = '';
  int readCurrentPos = 0;

  Lexer({required this.source}){
    _readChar();
  }
  void _readChar(){
    if(readCurrentPos >= source.length){
      currentChar = '0';
    }else{
      currentChar = source[readCurrentPos];
      position = readCurrentPos;
      readCurrentPos++;
    }
  }

  String _peekChar(){
    if(readCurrentPos >= source.length){
      return '';
    }else{
      return source[readCurrentPos];
    }
  }

  void _skipWhiteSpace() {
  while (currentChar.contains(RegExp(r'\s'))){
    _readChar();
  }
}

  bool _isLetter(String char){
    return char.contains(RegExp(r'[a-zA-Z_]'));
  }

  bool _isDigit(String char){
    return '0123456789'.contains(char);
  }

  String readNumber(){
    final pos = position;
    while(position < source.length && _isDigit(currentChar)){
      position++;
      if(position < source.length){
        currentChar = source[position];
      }
    }
    readCurrentPos = position;
    return source.substring(pos, position);
  }

  String readIdentifier(){
    final pos = position;
    while(position < source.length && (_isLetter(currentChar) || _isDigit(currentChar))){
      position++;
      if(position < source.length){
        currentChar = source[position];
      }
    }
    readCurrentPos = position;
    return source.substring(pos, position);
  }

  Token nextToken() {
    _skipWhiteSpace();
    Token? token;

    if(_isDigit(currentChar)) {
      String number = readNumber();
      token = Token(tokenType: TokenType.INT, literal: number);
      position = readCurrentPos;
      if (position < source.length) {
        currentChar = source[position];
      }
    } else if(_isLetter(currentChar)){
      String literal = readIdentifier();
      TokenType tokenType = Token.lookUpTokenType(literal);
      token = Token(tokenType: tokenType, literal: literal);
    } else if(currentChar == '=') {
      if(_peekChar() == '='){
        final char = currentChar;
        _readChar();
        token = Token(tokenType: TokenType.EQ, literal: char + currentChar);
      }else{
        token = Token(tokenType: TokenType.GT, literal: currentChar);
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
    } else {
      token = Token(tokenType: TokenType.ILLEGAL, literal: currentChar);
    }
    _readChar();
    return token;
  }
}