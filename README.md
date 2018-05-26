# bdg-sparklyr-sequila

```R
library(devtools)
install_github("ZSI-Bio/bdg-sparklyr-sequila")
library(sequila)
ss <- sequila_connect("local[1]")
sequila_sql(ss,'reads',"CREATE TABLE reads USING org.biodatageeks.datasources.BAM.BAMDataSource OPTIONS(path '/Users/marek/git/forks/bdg-sequila/src/test/resources/NA12878.slice.bam')")
sequila_sql(ss, 'coverage', "SELECT * FROM coverage('reads') where coverage>1 limit 5")
sequila_sql(ss, 'coverage', "SELECT * FROM coverage_hist('reads') where coverageTotal>10 limit 5")
sequila_disconnect(ss)
```
