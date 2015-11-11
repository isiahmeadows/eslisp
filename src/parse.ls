# Serves as an adapter from the S-expression parser's format to the internal
# AST objects.

parse-sexpr = require \sexpr-plus .parse

list = (values, location)  -> { type : \list values, location }
atom = (value, location)   -> { type : \atom value, location }
string = (value, location) -> { type : \string value, location }

convert = (tree) ->
  switch tree.type
  | \list   => list   (tree.content.map convert), tree.location
  | \atom   => atom   tree.content, tree.location
  | \string => string tree.content, tree.location
  | null    => throw Error "Unexpected type `#that` (of `#tree`)"

module.exports = parse-sexpr >> (.map convert)
