# recursive-lisp
Pair programming interview prompt for the Recurse Center

## Prompt

Write code that takes some Lisp code and returns an abstract syntax tree. The AST should represent the structure of the code and the meaning of each token. For example, if your code is given `(first (list 1 (+ 2 3) 9))`, it could return a nested array like `["first", ["list", 1, ["+", 2, 3], 9]]`.

During your interview, you'll pair on writing an interpreter to run the AST. You can start by implementing a single built-in function (for example, +) and add more if you have time.

## Grammar

### Lexer

```
int     : [0-9]+
float   : [0-9]+ "." (0-9)*
lparen  : "("
rparen  : ")"
name    : [a-z, A-Z]+
```

### Parser

```
sexp: atom | list

atom: name | number
list: "(" sexp (" " sexp)* ")"
```
