using Documenter, NLSolve

makedocs(
    format = :html,
    sitename = "NLSolve.jl",
    doctest = false,
    strict = false,
    pages = Any[
            "Home" => "index.md",
            "Getting Started" => "getting_started.md",
            "Examples" => "examples.md",
            "Tutorial" => "tutorial.md"
            ],
    # Use clean URLs, unless built as a "local" build
    html_prettyurls = !("local" in ARGS),
    html_canonical = "https://julianlsolvers.github.io/NLSolve.jl/"
    )

deploydocs(
    repo = "github.com/JuliaNLSolvers/NLSolve.jl.git",
    target = "build",
    julia = "0.6",
    deps = nothing,
    make = nothing,
)
