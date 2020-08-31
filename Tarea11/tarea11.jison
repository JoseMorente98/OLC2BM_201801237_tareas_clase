

%lex
%options case-insensitive
number  [0-9]+
decimal [0-9]+("."[0-9]+)
%%

\s+                   /* skip whitespace */
"//".*                /* skip comments */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* IGNORE */

{decimal}                   return 'NUMERO'
([a-zA-Z_])[a-zA-Z0-9_ñÑ]*	return 'ID';
"*"                         return '('
"*"                         return ')'
"*"                         return '*'
"/"                         return '/'
"-"                         return '-'
"+"                         return '+'

<<EOF>>                     return 'EOF';
.                           return 'TK_Desconocido';

/lex


%start Init

%%

Init    
    : S EOF 
    {
        return $1;
    } 
;

S
    : E {
        /* console.log($1.c3d) */
    }
;

E
    : E '+' T {
        /* E.Temp = new Temp() 
        E.c3d = $1.c3d + $3.c3d +
        E.Temp + '=' $1.Temp + '+' + $3.Temp */
    }
    | E '-' T {
        /* E.Temp = new Temp() 
        E.c3d = $1.c3d + $3.c3d +
        E.Temp + '=' $1.Temp + '-' + $3.Temp */
    }
    | T {
        /* E.Temp = $1.Temp E.c3d = $1.c3d */
    }
;

T
    : T '*' F {
        /* T.Temp = new Temp() 
        T.c3d = $1.c3d + $3.c3d +
        T.Temp + '=' $1.Temp + '*' + $3.Temp */
    }
    | T '/' F {
        /* T.Temp = new Temp() 
        T.c3d = $1.c3d + $3.c3d +
        T.Temp + '=' $1.Temp + '/' + $3.Temp */
    }
    | F {
        /* T.Temp = $1.Temp F.c3d = $1.c3d */
    }
;

F
    : '(' E ')' {
        /* F.Temp = $2.Temp F.c3d = $2.c3d */
    }
    | ID {
        /*  F.Temp = $1 F.c3d = '' */
    }
;
