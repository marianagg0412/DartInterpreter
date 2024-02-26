
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
}