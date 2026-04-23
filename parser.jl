const Token = Union{Number, String}

function lex(source::String)
    source = replace(source, "(" => " ( ", ")" => " ) ")
    source = split(source)
    tokens = Token[tokenize(String(t)) for t in source]
end

function tokenize(t::String)::Token

    float_regex = r"^[+-]?\d*\.\d*([eE][+-]?\d+)?$"
    int_regex = r"[+-]?[0-9]+"

    if occursin(float_regex, t)
        return parse(Float64, t)
    elseif occursin(int_regex, t)
        return parse(Int64, t)
    else
        return t
    end
end

file_stream = open(ARGS[1], "r")
content = read(file_stream, String)
print(lex(content))
