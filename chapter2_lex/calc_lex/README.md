# How lexer works
Use regexp to describe classes of words (like: Identifier, integer, floating, reserved words...)

Lex use the regexp specification to create a program.

This program will perform Lexical Analysis, segmenting input char stream into words.

# lexer for Calculator
[ML-lex_manual](https://www.cs.princeton.edu/~appel/modern/ml/ml-lex/manual.html)


The file "calc.lex" is used to generate a lexer program ("calc.lex.sml") used to catch the tokens inside a file like "calc_text"

File "calc.lex.sml" is generated from "calc.lex" with following command:

```
ml-lex calc.lex
```

File "calc.sml" is a program that uses "calc.lex.sml" to get the tokens, calculate numbers, and print them out.

## What the calculator can do
Read a file whose first line  contains a "print(1+2)" like statement.

The calculator works like an interpretor to run the command.




