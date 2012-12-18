vagrant-solr4
=============

Vagrant template for creating a simple solr4 virtual box based on the 'lucid64' base box

1. Basic Installation
```
vagrant up
```
2. Post Installation Steps

*Change directory owner
```
sudo chmod /etc/solr/data/
sudo chmod /etc/solr/zoo_data/
```

*Edit Solr/Tomcat configuration

Change the following entry in file /etc/solr/collection1/conf/solrconfig.xml
```
<dataDir>${solr.data.dir:/etc/solr/data}</dataDir>
```

Create the following file /etc/tomcat6/Catalina/localhost/solr.xml
```
<?xml version="1.0" encoding="utf-8"?>
<Context docBase="/etc/solr/solr.war" debug="0" crossContext="true">
  <Environment name="solr/home" type="java.lang.String" value="/etc/solr" override="true"/>
</Context>
```

*Optional: Adding SolrCloud configuration

For main cloud server add the following line to the tomcat startup script
```
export JAVA_OPTS="$JAVA_OPTS -Dbootstrap_confdir=/etc/solr/collection1/conf -Dcollection.configName=myconf -DzkRun -DnumShards=2"
```

For additional cloud server add the following line to the tomcat startup script
```
-DzkHost=<zk-host>:9983
```

*Additional information
http://wiki.apache.org/solr/SolrCloud
http://wiki.apache.org/solr/NewSolrCloudDesign
