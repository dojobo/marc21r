#' A collection of two MARC21 records provided by the LOC.
#'
#' A tibble of flattened records with subfields hidden, read using `marc21r::read_marcxml()` with the example MARC21 XML file on the LOC website.
#'
#' @format A tibble with 2 rows and 32 variables:
#' \describe{
#'   \item{id}{a numeric identifier (row number) for each record}
#'   \item{leader}{the leader field}
#'   \item{t001}{field 001, Control Number}
#'   \item{t003}{field 003, Control Number Identifier}
#'   \item{t005}{field 005, Date and Time of Latest Transaction}
#'   \item{t007}{field 007, Physical Description Fixed Field}
#'   \item{t008}{field 008, Fixed-Length Data Elements}
#'   \item{t010}{field 010, Library of Congress Control Number}
#'   \item{t028}{field 028, Publisher or Distributor Number}
#'   \item{t035}{field 035, System Control Number}
#'   \item{t040}{field 040, Cataloging Source}
#'   \item{t042}{field 042, Authentication Code}
#'   \item{t043}{field 043, Geographic Area Code}
#'   \item{t050}{field 050, Library of Congress Call Number}
#'   \item{t082}{field 082, Dewey Decimal Classification Number}
#'   \item{t245}{field 245, Title Statement}
#'   \item{t260}{field 260, Publication, Distribution, etc. (Imprint)}
#'   \item{t300}{field 300, Physical Description}
#'   \item{t500}{field 500, General Note}
#'   \item{t505}{field 505, Formatted Contents Note}
#'   \item{t511}{field 511, Participant or Performer Note}
#'   \item{t520}{field 520, Summary, etc.}
#'   \item{t538}{field 538, System Details Note}
#'   \item{t610}{field 610, Subject Added Entry—Corporate Name}
#'   \item{t650}{field 650, Subject Added Entry—Topical Term}
#'   \item{t700}{field 700, Added Entry—Personal Name}
#'   \item{t710}{field 710, Added Entry—Corporate Name}
#'   \item{t856}{field 856, Electronic Location and Access}
#'   \item{t906, t925, t955}{local fields}
#' }
#' @source \url{https://www.loc.gov/standards/marcxml/}
"loccoll"

#' Example MARC21 XML document
#'
#' A character vector, length 1.
#'
#' @source \url{https://www.loc.gov/standards/marcxml/}
"loccoll_xml"
