control_fields <- function(df) {
  df %>% dplyr::select(dplyr::starts_with("t00"))
}

main_entry_fields <- function(df) {
  df %>% dplyr::select(dplyr::starts_with("t1"))
}

title_fields <- function(df) {
  df %>% dplyr::select(dplyr::num_range("t", 200:249))
}

edition_fields <- function(df) {
  df %>% dplyr::select(dplyr::num_range("t", 250:289))
}

physical_fields <- function(df) {
  df %>% dplyr::select(dplyr::starts_with("t3"))
}

series_fields <- function(df) {
  df %>% dplyr::select(dplyr::starts_with("t4"))
}

note_fields <- function(df) {
  df %>% dplyr::select(dplyr::starts_with("t5"))
}

subject_fields <- function(df) {
  df %>% dplyr::select(dplyr::starts_with("t6"))
}

added_entry_fields <- function(df) {
  df %>% dplyr::select(dplyr::num_range("t", 700:759))
}

linking_entry_fields <- function(df) {
  df %>% dplyr::select(dplyr::num_range("t", 760:789))
}

series_added_entry_fields <- function(df) {
  df %>% dplyr::select(dplyr::num_range("t", 800:839))
}

holdings_etc_fields <- function(df) {
  df %>% dplyr::select(dplyr::num_range("t", 841:889))
}
