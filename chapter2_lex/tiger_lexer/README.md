# file content explanation
tokens.sig: Signature of the Tokens structure.

tokens.sml: The Tokens structure, containing the token type and constructors that your lexer should use to build instances of the token type type. It is important to do it in this way, so that things will still work when the "real" parser is attached to this lexer, and the "real" Tokens structure is used.

errormsg.sml: The ErrorMsg structure, useful for producing error messages with file names and line numbers.

driver.sml: A test scaffold to run your lexer on an input file.

tiger.lex: The beginnings of a real tiger.lex file

sources.cm: A "makefile" for the ML Compilation Manager

# tiger.lex

## how you handle comments

## how you handle strings

## error handling

## end-of-file handling

## other interesting features of your lexer


