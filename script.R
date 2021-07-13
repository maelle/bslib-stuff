library("rlang")

# "config file"
pkg <- list(
  meta = list(
    template = list(
      secondary = "orange"
    )
  )
)

bs_theme <- do.call(
  bslib::bs_theme,
  c(
    list(
      version = 4,
      bootswatch = NULL
    ),
    utils::modifyList(
      list(primary = "red"),
      pkg$meta[["template"]]$bslib %||% list()
    )
  )
)

# How do I modify the code below to
# a) use sass_file
# b) put the default variables in the sass files not in a list above
pkgdown_sass <- "sass/pkgdown.sass"
code_sass <- "sass/syntax-highlighting.sass"
all_sass <- paste(c(read_lines(pkgdown_sass), read_lines(code_sass)), collapse = "")
pkgdown_css <- sass::sass_partial(all_sass, bs_theme)
bs_theme <- bslib::bs_add_rules(bs_theme, pkgdown_css)

deps <- bslib::bs_theme_dependencies(bs_theme)
