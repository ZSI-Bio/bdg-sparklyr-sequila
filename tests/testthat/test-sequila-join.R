context("test-sequila-join.R")

master <- "local[1]"
driver_mem="2g"
ss<-sequila_connect(master,driver_memory=driver_mem)
library(sparklyr)
library(dplyr)
test_that("test SeQuiLa join", {

  sequila_sql(ss,query="CREATE DATABASE sequila")
  sequila_sql(ss,query="USE sequila")
  contigName<-c('1','1','1','1','1')
  start<-as.integer( c(100,200,400,10000,22100))
  end<-as.integer(c(190,290,600,20000,22100) )
  gr1 <- data.frame(contigName,start,end)
  gr1 <- copy_to(ss$sc, gr1, "gr1", overwrite = TRUE)

  contigName<-c('1','1','1','1','1','1')
  start<-as.integer( c(150,190,300,500,22000,15000) )
  end<-as.integer( c(250,300,500,700,22300,15000) )
  gr2 <- data.frame(contigName,start,end)
  gr2 <- copy_to(ss$sc, gr2, "gr2", overwrite = TRUE)
  query <- "SELECT gr1.contigName,gr1.start,gr1.end, gr2.start as start_2,gr2.end as end_2 FROM gr1 JOIN gr2
    ON (gr1.contigName=gr2.contigName AND gr1.end >= CAST(gr2.start AS INTEGER)
  AND gr1.start <= CAST(gr2.end AS INTEGER)) order by start"
  sequila_sql(ss,"results",paste("explain",query,sep=" "))
  res<- collect(sequila_sql(ss,'results',query))
  expect_equal(res$start, c(100,100,200,200,400,400,10000,22100))




  })

#sequila_disconnect(ss)
