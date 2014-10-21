class core {
  
    exec { "apt-update":
      command => "/usr/bin/sudo apt-get -y update"
    }
  
    package { 
      [ "vim", "git-core", "build-essential"]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }
}

class python {

    package { 
      [ "python", "python-setuptools", "python-dev", "python-pip"]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }

    exec {
      "virtualenv":
      command => "/usr/bin/sudo pip install virtualenv",
      require => Package["python-dev", "python-pip"]
    }

    exec {
      "ipython":
      command => "/usr/bin/sudo pip install ipython",
      require => Package["python-dev", "python-pip"]
    }

    exec {
      "requests":
      command => "/usr/bin/sudo pip install requests",
      require => Package["python", "python-pip"],
    }

}

class pythonxml {
	package {
		["libxml2-dev", "libxslt1-dev"]: 
		ensure => ["installed"],
        require => Exec['apt-update'] 
	}

	exec {
		"lxml":
		command => "/usr/bin/sudo pip install lxml",
		require => Package["libxml2-dev", "libxslt1-dev"],
	}
}

class saxonb {
  #command-line exes for xml processing (saxonb for xslt2 
  #transforms, xerces for pparse/stdinparse validation)
  package { 
      [ "libsaxonb-java", "default-jre" ]:
        ensure => ["installed"],
        require => Exec['apt-update']   
    }
}

class install_xerces {
    #wget http://www.trieuvan.com/apache//xerces/c/3/binaries/xerces-c-3.1.1-x86_64-linux-gcc-3.4.tar.gz
    #gzip -d xerces-c-3.1.1-x86_64-linux-gcc-3.4.tar.gz
    #tar -xf xerces-c-3.1.1-x86_64-linux-gcc-3.4.tar
    #export PATH="$PATH:/home/vagrant/xerces-c-3.1.1-x86_64-linux-gcc-3.4/bin"
    #export LD_LIBRARY_PATH=/home/vagrant/xerces-c-3.1.1-x86_64-linux-gcc-3.4/lib:$LD_LIBRARY_PATH
    
    Exec['wget gz'] -> File['xerces gz'] -> Exec["extract"] -> Exec["move xerces"] -> Exec["rm gz"]

    exec {
      "wget gz":
      path => "/home/vagrant",
      command => "/usr/bin/sudo /usr/bin/wget http://www.trieuvan.com/apache//xerces/c/3/binaries/xerces-c-3.1.1-x86_64-linux-gcc-3.4.tar.gz",
      require => Exec['apt-update']
    }

    file {
      "xerces gz":
      path => "/home/vagrant/xerces-c-3.1.1-x86_64-linux-gcc-3.4.tar.gz"
    }

    exec {
      "extract":
      path => "/bin:/usr/bin",
      command => "sudo tar -xzf /home/vagrant/xerces-c-3.1.1-x86_64-linux-gcc-3.4.tar.gz",
      creates => "/home/vagrant/xerces-c-3.1.1-x86_64-linux-gcc-3.4"
    }

    exec {
      "move xerces":
      command => "/usr/bin/sudo mv /home/vagrant/xerces-c-3.1.1-x86_64-linux-gcc-3.4 /usr/bin/xerces",
      creates => "/usr/bin/xerces"
    }

    exec {
      "rm gz":
      path => "/bin:/usr/bin",
      command => "/usr/bin/sudo rm /home/vagrant/xerces-c-3.1.1-x86_64-linux-gcc-3.4.tar.gz"
    }

}

include core
#include python
#include pythonxml
include saxonb
include install_xerces



