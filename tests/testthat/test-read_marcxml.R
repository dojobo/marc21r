test_that("right number of records", {
  coll <- read_marcxml("collection.xml")

  expect_equal(nrow(coll), 2)
})

test_that("hidden subfields are hidden", {
  coll <- read_marcxml("collection.xml",
                       subfield_style = "hidden")

  expect_equal(coll %>% filter(id==1) %>% pull(t260)
    , "New York, N.Y. : Atlantic, [1957?]")
})

test_that("flat repeating fields are flat", {
  coll <- read_marcxml("collection.xml",
                       repeating="flat")

  expect_equal(coll %>% filter(id==2) %>% pull(t610),
               "White House (Washington, D.C.); United States. Executive Office of the President.; United States. Office of the Vice President.; United States. Office of the First Lady.")
  expect_equal(coll %>% names() %>% length(),
               32)
  expect_equal(coll %>% select(starts_with("t610")) %>% names() %>% length(),
               1)
})
