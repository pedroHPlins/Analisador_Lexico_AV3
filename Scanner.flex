import java_cup.runtime.*;

%%

%class Scanner
%unicode
%cup
%line
%column

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]

digit = [0-9]
integer = {digit}+
float = {digit}+\.{digit}+

identifier = [a-zA-Z][a-zA-Z0-9]*

%%

<YYINITIAL> {
    "if"                { return symbol(sym.IF); }
    "else"              { return symbol(sym.ELSE); }
    
    "+"                 { return symbol(sym.PLUS); }
    "-"                 { return symbol(sym.MINUS); }
    "*"                 { return symbol(sym.TIMES); }
    "/"                 { return symbol(sym.DIVIDE); }
    "="                 { return symbol(sym.EQ); }
    ">"                 { return symbol(sym.GT); }
    "<"                 { return symbol(sym.LT); }
    "=="                { return symbol(sym.EQEQ); }
    
    "("                 { return symbol(sym.LPAREN); }
    ")"                 { return symbol(sym.RPAREN); }
    "{"                 { return symbol(sym.LBRACE); }
    "}"                 { return symbol(sym.RBRACE); }
    ";"                 { return symbol(sym.SEMICOLON); }
    
    {integer} { return symbol(sym.INTEGER, Integer.valueOf(yytext())); }
    {float}   { return symbol(sym.FLOAT, Float.valueOf(yytext())); }
    {identifier}        { return symbol(sym.ID, yytext()); }
    
    {WhiteSpace}        { /* ignore */ }
}

[^] { throw new Error("Caractere ilegal <"+yytext()+">"); }