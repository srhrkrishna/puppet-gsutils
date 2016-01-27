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
    command => 'sudo echo pathmunge /opt/gsutil > ~/custompath.sh && sudo mv ~/custompath.sh /etc/profile.d/ && sudo chmod +x /etc/profile.d/custompath.sh && . /etc/profile',
    require => Archive::Extract['gsutil'],
  }
}
