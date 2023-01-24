(* ML Declaration *)
type lexresult = Tokens.token
fun eof() = Tokens.EOF(0,0)
%%
(* Lex Definitions *)
digits = [0-9]+
%%
(* Regular Expressions and Actions *)
    if => (Tokens.IF(yypos,yypos+2));
       [a-z][a-zO-9]* => (Tokens.ID(yytext,yypos,yypos+size yytext));
       {digits} => (Tokens.NUM(Int.fromString yytext, yypos,yypos+size yytext));
       ({digits}"."[0-9]*)I([0-9]*"."{digits}) => (Tokens.REAL(Real.fromString yytext, yypos, yypos+size yytext));
        ("--"[a-z]*"\n")I(" "I"\n"I"\t")+
        => (continue() ) ;
        => (ErrorMsg.error yypos "illegal character"; continue() ) ;


