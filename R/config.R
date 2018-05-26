sequilaEnv <- new.env()
sequilaEnv$version <- "0.4-SNAPSHOT"
sequilaEnv$sparkVersion <- "2.2.1"
sequilaEnv$config <- sparklyr::spark_config()
sequilaEnv$config$sparklyr.defaultPackages <- paste("org.biodatageeks","bdg-sequila_2.11",sequilaEnv$version,sep=":")
sequilaEnv$config$sparklyr.shell.repositories <-"https://zsibio.ii.pw.edu.pl/nexus/repository/maven-snapshots/,https://zsibio.ii.pw.edu.pl/nexus/repository/maven-releases/"

.onLoad <- function(libname, pkgname){
  library(sparklyr)
  spark_install(version=sequilaEnv$sparkVersion)
  packageStartupMessage(paste("SeQuiLa-sparklyr",sequilaEnv$version, sep=" "))
  #cleanup
  system("rm -rf ~/.ivy2/cache/org.biodatageeks/bdg-sequila_2.11/*")
  system("rm -rf ~/.ivy2/jars/org.biodatageeks_bdg-sequila_2.11*")
}
