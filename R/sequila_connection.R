sequila_connect <- function(master,driver_memory, executor_memory = "1g", executor_num = 1) {
  sequilaEnv$config$`sparklyr.shell.driver-memory` <- driver_memory
  sequilaEnv$config$spark.executor.memory <- executor_memory
  sequilaEnv$config$spark.executor.instances <- executor_num
  sc<- spark_connect(master=master ,config=sequilaEnv$config,version=sequilaEnv$sparkVersion,app_name = "SeQuiLa")
  session = sparklyr::invoke_static(sc, "org.biodatageeks.R.SequilaR","init")
  ss <- new.env()
  ss$session <-session
  ss$sc <-sc
  ss
}

sequila_disconnect <- function(session){
  spark_disconnect(ss$sc)
}
