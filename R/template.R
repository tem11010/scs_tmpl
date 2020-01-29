#' @importFrom rmarkdown includes pdf_document
NULL

#' Render a document to a specified directory
#'
#' @param output_dir passed to [rmarkdown::render]
#'
#' @export
knit_to <- function(output_dir) {
  force(output_dir)
  function(input,encoding) {
    rmarkdown::render(input, encoding = encoding, output_dir=output_dir)
  }
}


assets <- function(file) {
  system.file(
    "assets", file,
    package = "scsuconn"
  )
}

##' Location of uconntemplate.tex
##'
##' @export
uconn_template <- function() {
  assets("uconntemplate.tex")
}

##' Location of uconn beamer template
##'
##' @export
uconn_beamer_template <- function() {
  assets("beamer_template.tex")
}

##' Location of uconnlogo.pdf file
##' @export
uconn_logo <- function() {
  assets("uconnlogo.png")
}

##' Return a list of includes
##'
##' @param header by default `header.tex`
##' @param ... passed to [rmarkdown::includes]
##' @export
uconn_include <- function(header = assets("header.tex"), ...) {
  rmarkdown::includes(in_header = header, ...)
}

##' UConn document engine
##'
##' @param template see [rmarkdown::pdf_document]
##' @param fig_width see [rmarkdown::pdf_document]
##' @param fig_height see [rmarkdown::pdf_document]
##' @param keep_tex see [rmarkdown::pdf_document]
##' @param toc see [rmarkdown::pdf_document]
##' @param number_sections see [rmarkdown::pdf_document]
##' @param includes see [rmarkdown::pdf_document]
##' @param ... passed to [rmarkdown::pdf_document]
##' @export
uconn_document <- function(template = uconn_template(),
                         fig_width = 6, fig_height = 4,
                         keep_tex = TRUE,
                         toc = TRUE, number_sections = TRUE,
                         includes = uconn_include(), ...) {

  rmarkdown::pdf_document(
    toc = toc, keep_tex = keep_tex, includes = includes,
    fig_width = fig_width, fig_height = fig_height, template = template,
    ...
  )
}

##' uconn presentation engine
##'
##' Build a beamer presentation with uconn branding.
##'
##' @param template see [rmarkdown::beamer_document]
##' @param toc  not used
##' @param includes see [rmarkdown::beamer_document]
##' @param theme see [rmarkdown::beamer_document]
##' @param ... passed to [rmarkdown::beamer_document]
##' @export
uconn_beamer <- function(template = uconn_beamer_template(),
                       toc = TRUE, theme = "CambridgeUS",
                       includes = list()) {

  rmarkdown::beamer_presentation(
    toc = toc, includes = includes, theme = theme,
    template = template
  )
}
