/* description: Clojure. */

/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
"("                   return "("
")"                   return ")"
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
"+"                   return '+'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '+' '-'
%left '*' '/'
%left '^'
%right '!'
%right '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : e EOF
        { typeof console !== 'undefined' ? console.log(JSON.stringify($1)) : print($1);
          return $1; }
    ;

e
    : '(' '+' args ')'
        { $$ = [$2].concat([$3])}
    | NUMBER
        { $$ = Number(yytext);}
    ;

args
    : args NUMBER
        { $$ = $1.concat($2)}
    |args e
        { $$ = $1.concat([$2])}
    | NUMBER
        { $$ = [$1]}
    ;
