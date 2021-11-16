\name{literature}
\alias{literature}
\docType{data}
\title{
Studies on redistricting
}
\description{
A dataset containing the relationships between concepts identified in the redistricting literature.
}
\usage{data("literature")}
\format{
  A data frame with 69 observations on the following 10 variables.
  \describe{
    \item{\code{core}}{a logical vector}
    \item{\code{from}}{a character vector}
    \item{\code{edge}}{a character vector}
    \item{\code{to}}{a character vector}
    \item{\code{cites_pre2010}}{a character vector}
    \item{\code{cites}}{a character vector}
    \item{\code{cites_empirical}}{a character vector}
    \item{\code{mechanism}}{a character vector}
    \item{\code{cite_weight}}{a numeric vector}
    \item{\code{cite_empirical_weight}}{a numeric vector}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
\url{https://github.com/judgelord/redistricting-lit}
}
\examples{
data(literature)
}
\keyword{datasets}
