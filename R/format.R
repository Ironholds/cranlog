simple_grep <- function(x, pattern){
  return(grepl(x = x, pattern = pattern, fixed = TRUE, useBytes = TRUE))
}

format_r_os <- function(r_oses){
  r_oses[simple_grep(r_oses, "linux-gnu")] <- "Linux"
  r_oses[simple_grep(r_oses, "darwin")] <- "OSX"
  r_oses[simple_grep(r_oses, "freebsd")] <- "FreeBSD"
  r_oses[simple_grep(r_oses, "dragonfly")] <- "FreeBSD"
  r_oses[simple_grep(r_oses, "solaris")] <- "Solaris"
  r_oses[simple_grep(r_oses, "mingw")] <- "Windows"
  r_oses[!r_oses %in% c("Linux","OSX", "FreeBSD", "Solaris","Windows")] <- "Unknown/Other"
  return(r_oses)
}

#'@title Format Downloaded CRAN Logs
#'@description the CRAN logs are in a highly sensible format but some of the fields
#'haven't had their values abstracted away to easily human-readable ones. \code{format_logs}
#'performs this operation, starting with refactoring the \code{r_os} field to contain values
#'like "Windows" or "OSX" instead of "mingw32" or "darwin".
#'
#'@param logs a data.frame of log data obtained through \code{read_logs}.
#'
#'@return a data.frame identical to \code{logs} but with a reformatted \code{r_os} field.
#'
#'@examples
#'
#'# Read in and format the logs from the day before yesterday.
#'\dontrun{
#'formatted_data <- format_logs(read_logs())
#'}
#'@export
format_logs <- function(logs){
  logs$r_os <- format_r_os(logs$r_os)
  return(logs)
}