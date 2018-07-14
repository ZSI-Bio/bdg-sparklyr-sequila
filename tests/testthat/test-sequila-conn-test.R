context("test-sequila-conn-test.R")

test_that("test SeQuiLa connection", {
  master <- "local[1]"
  driver_mem="1g"
  ss<-sequila_connect(master,driver_memory=driver_mem)
  expect_equal(ss$sc$master, master)
  expect_equal(ss$sc$config$`sparklyr.shell.driver-memory`, driver_mem)
  #sequila_disconnect(ss)
})
