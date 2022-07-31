#' Apply readable names to a MARC dataframe.
#'
#' @param df A dataframe or dataframe extension (e.g., tibble)
#' @param style Whether names should be `short` (default), i.e., abbreviated, or `long`, using the official Library of Congress designations.
#'
#' @return A tibble.
#' @export
#'
#' @examples # TODO
tag_names <- function(df, style="short") {
  extant_tags <- names(df)
  extant_tags <- str_remove_all(extant_tags, "^t")
  extant_tags <- tibble(tag = extant_tags)

  marc_fields <- readRDS("marc_fields.rds")
  extant_tags <- extant_tags %>%
    left_join(y=marc_fields)

  if (style == "short") {
    new_names <- extant_tags %>%
      mutate(short_name = coalesce(short_name, tag)) %>%
      pull(short_name)
  } else if (style == "long") {
    new_names <- extant_tags %>%
      mutate(long_name = coalesce(long_name, tag)) %>%
      pull(long_name)
  }

  new_names <- str_replace(new_names, "^(\\d)", "t\\1")
  names(df) <- new_names
  return(df)
}

