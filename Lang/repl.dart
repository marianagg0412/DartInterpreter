// ignore_for_file: unnecessary_string_escapes

import 'lexer.dart';
import 'dart:io';

import 'token.dart';

void startRepl() {
  stdout.write('>>> ');

  while (true) { // Loop continuously for REPL
    String? input = stdin.readLineSync();

    if (input == null || input == 'exit') { // Check for exit conditions
      break; // Exit the loop
    }

    try { // Handle potential errors
      final lexer = Lexer(source: input);
      while (lexer.currentChar != String.fromCharCode(00)) { // Process tokens until EOF
        final token = lexer.nextToken();
        if(token.tokenType != TokenType.EOF){
          print(token);
        }
      }
    } catch (error) {
      print('Error: $error'); // Handle errors gracefully
    }

    stdout.write('>>> ');
  }
}
