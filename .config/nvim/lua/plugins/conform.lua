require("conform").setup({
    formatters = {
        runic = {
            command = "julia",
            args = {"--project=@runic", "-e", "'using Runic; exit(Runic.main(ARGS))'"},
        },
    },
    formatters_by_ft = {
        julia = {"runic"},
    },
    default_format_opts = {
        -- Increase the timeout in case Runic needs to precompile
        -- (e.g. after upgrading Julia and/or Runic).
        timeout_ms = 10000,
    },
    log_level=vim.log.levels.DEBUG
})
