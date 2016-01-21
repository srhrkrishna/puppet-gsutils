class gsutil(
  $install_dir = $::gsutil::params::install_dir
) inherits gsutil::params {

  validate_absolute_path($install_dir)

  File { owner => 'root', group => 'root', mode => '0666', }  

  archive::download { $download_filename: 
    url => $download_source,
    checksum => false,
  }

  archive::extract { 'gsutil': 
    target => $install_dir,
    require => Archive::Download[$download_filename],
  }

  exec { 'install Google gsutil':
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    creates => ["${install_dir}/gsutil", '/etc/profile.d/custompath.sh'],
    cwd => "${install_dir}/gsutil",
    command => 'sudo echo pathmunge /opt/gsutil > ~/custompath.sh && sudo mv ~/custompath.sh /etc/profile.d/ && sudo chmod +x /etc/profile.d/custompath.sh && . /etc/profile',
    require => Archive::Extract['gsutil'],
  }
}