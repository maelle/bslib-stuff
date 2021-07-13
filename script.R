library("rlang")

# "config file"
pkg <- list(
  meta = list(
    template = list(
      secondary = "orange"
    )
  )
)

theme <- do.call(
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
pkgdown_css <- sass::sass_partial(
  list(
    sass::sass_file("sass/pkgdown.scss"),
    sass::sass_file("sass/syntax-highlighting.scss")
  ),
  theme
)
bs_theme <- bslib::bs_add_rules(theme, pkgdown_css)

deps <- bslib::bs_theme_dependencies(theme)
