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
		command => "wget http://apache.mirror.iphh.net/lucene/solr/4.0.0/apache-solr-4.0.0.tgz",
		cwd => "/home/vagrant/",
		creates => "/home/vagrant/apache-solr-4.0.0.tgz",
		path => ["/usr/bin", "/usr/sbin/"]
	}

	exec { "solr-inflate":
		command => "tar xzf apache-solr-4.0.0.tgz",
		cwd => "/home/vagrant/",
		creates => "/home/vagrant/apache-solr4/",
		path => "/bin/",
		require => Exec["solr-download"]
	}

	exec { "solr-createdirectory":
		command => "mkdir /etc/solr/",
		cwd => "/home/vagrant/",
		path => ["/usr/bin", "/usr/sbin/", "/bin/"],
	}

	exec { "solr-createzoodirectory":
		command => "mkdir /etc/solr/zoo_data/",
		cwd => "/home/vagrant/",
		path => ["/usr/bin", "/usr/sbin/", "/bin/"],

	}

	exec { "solr-install":
		command => "cp -R apache-solr-4.0.0/example/solr/* /etc/solr/ | cp -R apache-solr-4.0.0/example/webapps/solr.war /etc/solr/",
		cwd => "/home/vagrant/",
		path => ["/usr/bin", "/usr/sbin/", "/bin"],
		require => Exec["solr-inflate"]
	}

}


include system
include apache
include tomcat
include solr