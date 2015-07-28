## cranlog
A package for reading and formatting the [CRAN download logs](http://cran-logs.rstudio.com/)

__Author:__ Oliver Keyes<br/>
__License:__ [MIT](http://opensource.org/licenses/MIT)<br/>
__Status:__ Stable

RStudio provides download logs showing the downloads of R packages from their CRAN mirror. This package
contains simple functions for downloading, reading and (slightly) reformatting those logs, letting
you analyse away without worrying about getting the information in the first place.

###Installation

There isn't currently a CRAN version (amusingly) but the initial release can be obtained with

    devtools::install_github("ironholds/cranlog", ref = "0.1.0")
    
It depends on the `readr` package to work; that you *can* get from CRAN.
