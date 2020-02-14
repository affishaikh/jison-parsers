const Parser = require("jison").Parser;

const grammar = {
  lex: {
    rules: [
      ["\\s+", "return 'SPACE';"],
      ["[A-z0-9]+", "return 'Word';"]
    ]
  },

  bnf: {
    SentenceWithNumbers: ["SentenceWithNumbers SPACE Word", "Word"]
  }
};

const parser = new Parser(grammar);

console.log(parser.parse("string"));
console.log(parser.parse("some     big sentence like this"));
console.log(parser.parse("420 k"));
console.log(parser.parse("khiladi 420 k"));
console.log(parser.parse("420k"));
