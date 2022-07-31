#' Apply readable names to a MARC dataframe.
#'
#' @param df A dataframe or dataframe extension (e.g., tibble)
#' @param style Whether names should be `short` (default), i.e., abbreviated, or `long`, using the official Library of Congress designations.
#'
#' @import dplyr
#' @import stringr
#'
#' @return A tibble.
#' @export
#'
#' @examples # TODO
tag_names <- function(df, style="short") {
  extant_tags <- names(df)
  extant_tags <- stringr::str_remove_all(extant_tags, "^t")
  extant_tags <- dplyr::tibble(tag = extant_tags)

  load("R/sysdata.rda")  # instantiate marc_fields
  extant_tags <- extant_tags %>%
    dplyr::left_join(y=marc_fields)

  if (style == "short") {
    new_names <- extant_tags %>%
      dplyr::mutate(short_name = coalesce(short_name, tag)) %>%
      dplyr::pull(short_name)
  } else if (style == "long") {
    new_names <- extant_tags %>%
      dplyr::mutate(long_name = dplyr::coalesce(long_name, tag)) %>%
      dplyr::pull(long_name)
  }

  new_names <- stringr::str_replace(new_names, "^(\\d)", "t\\1")
  names(df) <- new_names
  return(df)
}

