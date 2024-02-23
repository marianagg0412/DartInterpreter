// ignore_for_file: unnecessary_string_escapes

import 'lexer.dart';
import 'dart:io';

void startRepl() {
  stdout.write('>>> ');

  while (true) { // Loop continuously for REPL
    String? input = stdin.readLineSync();

    if (input == null || input == 'exit') { // Check for exit conditions
      break; // Exit the loop
    }

    try { // Handle potential errors
      final lexer = Lexer(source: input);

      while (lexer.currentChar != '\0') { // Process tokens until EOF
        final token = lexer.nextToken();
        print(token);
      }
    } catch (error) {
      print('Error: $error'); // Handle errors gracefully
    }

    stdout.write('>>> ');
  }
}
