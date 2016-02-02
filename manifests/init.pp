# The main file of gsutil puppet module
# Inherits from params file

class gsutil(
# Derives the Installation Directory
  $install_dir = $::gsutil::params::install_dir
) inherits gsutil::params {

# Validates if the installation directory path exists
  validate_absolute_path($install_dir)

# Assigns the directory access permissions for the installation directory
  File { owner => 'root', group => 'root', mode => '0666', }  

# The below block of code downloads the gsutil archive file.
  archive::download { $download_filename: 
    url => $download_source,
    checksum => false,
  }

# The below block of code extracts the gsutil archive file.
  archive::extract { 'gsutil': 
    target => $install_dir,
    require => Archive::Download[$download_filename],
  }

# The below block of code installs the gsutil archive file.
  exec { 'install Google gsutil':
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    creates => ["${install_dir}/gsutil", '/etc/profile.d/custompath.sh'],
    cwd => "${install_dir}/gsutil",
  #  command => 'sudo echo pathmunge /opt/gsutil > ~/custompath.sh && sudo mv ~/custompath.sh /etc/profile.d/ && sudo chmod +x /etc/profile.d/custompath.sh && . /etc/profile',
#     command => 'source /etc/profile.d/install_gsutil.sh',
    require => Archive::Extract['gsutil'],
  }

# The below code will set the gsutil path inside the PATH env variable.
file { "/etc/profile.d/install_gsutil.sh":
  content => "export PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/gsutil",
  mode    => 755
}-> exec { 'set gsutil':
    provider => shell,
    command => "source /etc/profile.d/install_gsutil.sh",
    logoutput => on_failure,
  }

}
