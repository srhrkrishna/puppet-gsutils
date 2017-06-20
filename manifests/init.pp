# The main file of gsutil puppet module
# Inherits from params file

class gsutil(
# Derives the Installation Directory
  $install_dir = 'UNSET'
) inherits gsutil::params {

  $install_dir_final = $install_dir ? {
    'UNSET' => $::gsutil::params::install_dir,
    default => $install_dir,
}

  notify {"FileName : $download_filename":}
  notify {"Install : $install_dir":}
  notify {"Source : $download_source":}

# Validates if the installation directory path exists
  validate_absolute_path($install_dir_final)

# Assigns the directory access permissions for the installation directory
  File { owner => 'root', group => 'root', mode => '0666', }

# The below block of code downloads the gsutil archive file.

    archive::download { $download_filename:
    url => $download_source,
    checksum => false,
  
  }

# The below block of code extracts the gsutil archive file.
  archive::extract { 'gsutil':
    target  => $install_dir_final,
    require => Archive::Download[$download_filename],
  }

# The below block of code installs the gsutil archive file.
  exec { 'install Google gsutil':
    path    => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    creates => ["${install_dir_final}/gsutil", '/etc/profile.d/custompath.sh'],
    cwd     => "${install_dir_final}/gsutil",
#     command => 'source /etc/profile.d/install_gsutil.sh',
    require => Archive::Extract['gsutil'],
  }

# The below code will set the gsutil path inside the PATH env variable.
file { '/etc/profile.d/install_gsutil.sh':
  content => 'export PATH=$PATH:/usr/local/bin:/usr/bin:/opt/gsutil',
  mode    => '0755'
}-> exec { 'set gsutil':
    provider  => shell,
    command   => 'source /etc/profile.d/install_gsutil.sh',
    logoutput => on_failure,
  }

}
