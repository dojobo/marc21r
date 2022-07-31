read_marcxml <- function(x,
                         subfield_style="hidden",
                         repeating="flat"
                         ) {
  xml_doc <- read_xml(x)

  controlfields <- xml_find_all(xml_doc, ".//marc:controlfield")
  control_tags <- paste("t", xml_attr(controlfields, "tag"), sep="")
  xml_set_name(controlfields, control_tags)

  datafields <- xml_find_all(xml_doc, ".//marc:datafield")
  data_tags <- paste("t", xml_attr(datafields, "tag"), sep="")
  xml_set_name(datafields, data_tags)

  subfields <- xml_find_all(xml_doc, ".//marc:subfield")
  for (subfield in subfields) {
    parent_name <- xml_name(xml_parent(subfield))
    new_name <- paste(parent_name, xml_attr(subfield, "code"), sep="")
    xml_set_name(subfield, new_name)
  }

  df <- suppressMessages({ as_tibble(as_list(xml_doc)) %>%
    rename(record = "collection") %>%
    unnest_wider(record) %>%
    mutate(id = row_number(), .before=1) })

  # fun to return a list-column entry list() as a flat string
  # note that we don't care about punctuation between subfields here
  clean_entry <- function(entry) {
    if (is_null(entry)) {
      return(NA)
    }
    # TODO: if subfield style is inline...
    entry <- unlist(entry)
    return(paste(entry, collapse=" "))
  }

  # flatten atomic fields:
  atomic_fields <- c("leader", unique(substr(str_subset(names(coll), "(^t0[0-3]|^t05|^t1)"), 1, 4)))
  for (field in atomic_fields) {
    df <- df %>%
      mutate({{field}} := unlist(.data[[field]]))
  }

  if (subfield_style == "inline") {  # $a foo : $b bar
  # TODO

  } else if (subfield_style == "hidden") {  # foo : bar
    df <- df %>%
      rowwise() %>%
      mutate(t040=clean_entry(t040)) %>%
      mutate(t042=clean_entry(t042)) %>%
      mutate(t043=clean_entry(t043)) %>%
      mutate(t082=clean_entry(t082)) %>%
      mutate(t245=clean_entry(t245)) %>%
      mutate(t256=clean_entry(t256)) %>%
      mutate(t260=clean_entry(t260)) %>%
      mutate(t300=clean_entry(t300))

  } else if (subfield_style == "unnested") {  # each subfield a column
  # TODO

  }

  if (repeating == "flat") {  # subject1; subject2
    repeating_fields <- unique(substr(str_subset(names(coll), "^t[456789]"), 1, 4))
    for (field in repeating_fields) {
      field_new <- paste0(field, "_new")
      # combine all iterations of the field into one column,
      # and clean entries:
      df <- df %>%
        pivot_longer(cols=starts_with(field),
                     names_to="tmp",
                     values_to={{field_new}}) %>%
        mutate({{field_new}} := map_chr(.data[[field_new]], clean_entry))

      # transform entries into flat strings,
      # and combine entries into an atomic value:
      df <- df %>%
        group_by(id) %>%
        mutate({{field_new}} := str_flatten(.data[[field_new]], collapse="; ")) %>%
        mutate(tmp=.data[[field_new]]) %>%
        select(-starts_with(field)) %>%
        mutate({{field}} := tmp) %>%
        select(-tmp) %>%
        distinct() %>%
        ungroup()
    }

  } else if (repeating == "list") {  # repeated fields in a list() object
  # TODO
  } else if (repeating == "unnested") {  # each repeated field a column
  # TODO
  }

  if ("tmp" %in% names(df)) {
    df <- df %>%
      select(-tmp)
  }

  df <- df %>%
    select(order(colnames(df)))

  return(df)
}

