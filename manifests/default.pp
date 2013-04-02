# Basic Puppet Apache manifest

# installing updates and additional tools
class system {
	
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  package { "vim":
  	ensure => present,
  }

  package { "curl":
  	ensure => present, 
  }

}

# setting up apache2 as service
class apache {

  package { "apache2":
  	ensure => present,
  }
  
  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }

}

# setting up tomcat as service
class tomcat {

  package { "tomcat6":
  	ensure => present,
  }
  
  service { "tomcat6":
    ensure => running,
    require => Package["tomcat6"],
  }

}

# setting up solr4 
class solr {

	exec { "solr-download":
		command => "wget http://mirror.serversupportforum.de/apache/lucene/solr/4.2.0/solr-4.2.0.tgz",
		cwd => "/home/vagrant/",
		creates => "/home/vagrant/apache-solr-4.2.0.tgz",
		path => ["/usr/bin", "/usr/sbin/"]
	}

	exec { "solr-inflate":
		command => "tar xzf apache-solr-4.2.0.tgz",
		cwd => "/home/vagrant/",
		creates => "/home/vagrant/solr-4.2.0/",
		path => "/bin/",
		require => Exec["solr-download"]
	}

}

# downloading zookeeper
class zookeeper {

	exec { "zk-download":
		command => "wget http://mirror.serversupportforum.de/apache/zookeeper/zookeeper-3.4.5/zookeeper-3.4.5.tar.gz",
		cwd => "/home/vagrant/",
		creates => "/home/vagrant/zookeeper-3.4.5.tar.gz",
		path => ["/usr/bin", "/usr/sbin/"]
	}

	exec { "zk-inflate":
		command => "tar xzf zookeeper-3.4.5.tar.gz",
		cwd => "/home/vagrant/",
		creates => "/home/vagrant/zookeeper-3.4.5/",
		path => "/bin/",
		require => Exec["zk-download"]
	}

}


include system
include apache
include tomcat
include solr