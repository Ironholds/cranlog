construct_path <- function(date){
  date <- as.character(date)
  year <- substr(date, 0, 4)
  path <- paste0("http://cran-logs.rstudio.com/", year, "/", date, ".csv.gz")
  return(path)
}

read_single_log <- function(date){
  holding <- tempfile()
  download.file(url = construct_path(date), destfile = holding, quiet = TRUE)
  con <- gzfile(holding)
  data <- readr::read_csv(file = con)
  file.remove(holding)
  return(data)
}

#'@title Read CRAN Download Logs
#'@description foo
#'
#'@param start a Date object indicating the start of the range to read. Defaults to the day before yesterday;
#'CRAN logs are updated on a one-day lag and a two-day lag allows for timezone differences.
#'
#'@param end a Date object indicating the end of the range to read. Defaults to NULL, in which case 'start' will
#'be taken as the only date to read for.
#'
#'@importFrom readr read_csv
#'
#'@examples
#'# Read a single day's logs from 5 days ago.
#'data <- read_logs(start = Sys.Date() - 5)
#'
#'# Read everything between 5 July and 10 July
#'\dontrun{
#'data <- read_logs(start = as.Date("2015-07-05"), end = as.Date("2015-07-10"))
#'}
#'@export
read_logs <- function(start = (Sys.Date()-2), end = NULL){

  if(!"Date" %in% class(start)){
    stop("'start' must be a date")
  }

  if(is.null(end)){
    range <- start
  } else {
    if(!"Date" %in% class(end)){
      stop("'end' must be a date")
    }
    range <- seq(start, end, "day")
  }

  results <- lapply(range, read_single_log)
  return(do.call("rbind", results))
}