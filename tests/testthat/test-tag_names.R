test_that("short names work", {
  coll <- read_marcxml("collection.xml")

  expect_equal(coll %>% tag_names("short") %>% select(starts_with("t001")) %>% names(),
               "t001_ctrl_no")

})

test_that("long names work", {
  coll <- read_marcxml("collection.xml")

  expect_equal(coll %>% tag_names("long") %>% select(starts_with("t001")) %>% names(),
               "t001_Control Number")

})
