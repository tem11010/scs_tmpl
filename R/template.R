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


##' Location of uconnlogo file
##' @export
uconn_logo <- function() {
  system.file("assets","uconnlogo.png",package = "scsuconn")
}

##' Return a list of includes
##'
##' @param header by default `header.tex`
##' @param ... passed to [rmarkdown::includes]
##' @export
uconn_include <- function(header = system.file("rmarkdown/templates/uconn_document/resources/header.tex",package = 'scsuconn'), ...) {
  rmarkdown::includes(in_header = header, ...)
}

##' UConn document engine
##'
##' @param fig_width see [rmarkdown::pdf_document]
##' @param fig_height see [rmarkdown::pdf_document]
##' @param keep_tex see [rmarkdown::pdf_document]
##' @param toc see [rmarkdown::pdf_document]
##' @param number_sections see [rmarkdown::pdf_document]
##' @param includes see [rmarkdown::pdf_document]
##' @param \dots passed to [rmarkdown::pdf_document]
##' @export
uconn_document <- function(...,
                           fig_width = 6,
                           fig_height = 4,
                           keep_tex = TRUE,
                           toc = TRUE,
                           number_sections = TRUE,
                           includes = uconn_include()) {

  pdf_document_format("uconn_document", toc = toc, keep_tex = keep_tex, includes = includes,
                      fig_width = fig_width, fig_height = fig_height,
                      ...)

}

##' uconn presentation engine
##'
##' Build a beamer presentation with uconn branding.
##'
##' @param \dots passed to [rmarkdown::beamer_presentation]
##' @export
uconn_presentation <- function(...) {

  beamer_presentation_format("uconn_presentation", ...)

}

find_resource <- function(template, file = 'template.tex') {
  res <- system.file(
    "rmarkdown", "templates", template, "resources", file, package = "scsuconn"
  )
  if (res == "") stop(
    "Couldn't find template file ", template, "/resources/", file, call. = FALSE
  )
  res
}

# Helper function to create a custom format derived from pdf_document that
# includes a custom LaTeX template
pdf_document_format <- function(
  format, template = find_resource(format, 'template.tex'), ...
) {
  fmt <- rmarkdown::pdf_document(..., template = template)
  fmt$inherits <- "pdf_document"
  fmt
}

beamer_presentation_format <- function(
  format, template = find_resource(format, 'template.tex'), ...
) {
  fmt <- rmarkdown::beamer_presentation(..., template = template)
  fmt$inherits <- "beamer_presentation"
  fmt
}