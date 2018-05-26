sequila_connect <- function(master) {
  sc<- spark_connect(master=master ,config=sequilaEnv$config,version=sequilaEnv$sparkVersion,app_name = "SeQuiLa")
  session = sparklyr::invoke_static(sc, "org.biodatageeks.R.SequilaR","init")
  ss$session <-session
  ss$sc <-sc
  ss
}

sequila_disconnect <- function(session){
  spark_disconnect(ss$connection)
}
