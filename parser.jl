const Token = Union{Number, String}

function lex(source::String)
    # Pad parentheses with spaces for
    # whitespace based splitting
    source = replace(source, "(" => " ( ", ")" => " ) ")
    source = split(source)
    tokens = Token[match_token(String(t)) for t in source]
end

function match_token(t::String)::Token
    # Match 123. 123.45 and .45 but not 123
    # Also match +/- and scientific notation
    float_regex = r"^[+-]?\d*\.\d*([eE][+-]?\d+)?$"
    # Match +/- integers
    int_regex = r"[+-]?[0-9]+"

    # Match floats first so that integers aren't
    # accidentally matched
    if occursin(float_regex, t)
        return parse(Float64, t)
    elseif occursin(int_regex, t)
        return parse(Int64, t)
    else
        return t
    end
end

function Base.parse(tokens::Vector{Token})
    x = popfirst!(tokens)
    if x == "("
        sexp = []
        while tokens[1] != ")"
            push!(sexp, Base.parse(tokens))
        end
        popfirst!(tokens)
        return sexp
    else
        return x
    end

end

file_stream = open(ARGS[1], "r")
content = read(file_stream, String)
print(content |> lex |> Base.parse)
