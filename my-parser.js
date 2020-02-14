const Parser = require("jison").Parser;

const grammar = {
  lex: {
    rules: [
      ["\\s+", "return 'SPACE';"],
      ["[A-z0-9]*[A-z]+[0-9]*", "return 'Word';"],
      ["[0-9]+", "return 'Number';"]
    ]
  },

  bnf: {
    SentenceWithNumbers: ["SentenceWithNumbers SPACE Word", "Word", "Number"]
  }
};

const parser = new Parser(grammar);

console.log(parser.parse("string"));
console.log(parser.parse("some     big sentence like this"));
console.log(parser.parse("420k"));
console.log(parser.parse("888"));