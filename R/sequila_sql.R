sequila_sql <-function(ss,tbl_name= "test", query,cache_table = FALSE) {

  seq_df<-sparklyr::invoke(ss$session, "sql",query)
  sparklyr::invoke_static(ss$sc, "org.biodatageeks.R.SequilaR","dropTempView",ss$session,tbl_name)
  spark_tbl = sparklyr:::spark_partition_register_df(ss$sc, seq_df, tbl_name, 0, cache_table)
  spark_tbl
}
