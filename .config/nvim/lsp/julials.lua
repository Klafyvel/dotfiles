return {
    cmd = {"julia", "--startup-file=no", "--history-file=no", "--project=@languageserver", "-e", [[
    using LanguageServer
    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
    project_path = dirname(something(
        Base.load_path_expand((
            p = get(ENV, "JULIA_PROJECT", nothing);
            p === nothing ? nothing : isempty(p) ? nothing : p
        )),
        Base.current_project(),
        get(Base.load_path(), 1, nothing),
        Base.load_path_expand("@v#.#"),
    ))
    @info "Running language server" VERSION pwd() project_path depot_path
    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
    server.runlinter = true
    run(server)
    ]]
    },
    filetypes = { "julia" },
    root_markers = { "Project.toml", ".git/" }
}
