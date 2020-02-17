/* description: HTML parser. */

/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
\<[a-z 0-9]+\>            return 'TAG_O'
\<\/[a-z 0-9]+\>          return 'TAG_C'
[a-z]+                    return 'TEXT'
<<EOF>>                   return 'EOF'
.                         return 'INVALID'

/lex

%start expressions

%% /* language grammar */

expressions
    : ROOT EOF
        { typeof console !== 'undefined' ? console.log(JSON.stringify($1)) : print($1);
          return $1; }
    ;

ROOT
    : TAG_O ELEMENT TAG_C
        {$$ = [$1].concat([$2]).concat([$3])}
    ;

ELEMENT
    : TAG_O ELEMENT TAG_C ELEMENT
        {$$ = [[$1].concat([$2]).concat([$3])].concat($4)}
    | TAG_O TEXT TAG_C ELEMENT
        {$$ = [[$1].concat([$2]).concat([$3])].concat($4)}
    | ''
    ;
