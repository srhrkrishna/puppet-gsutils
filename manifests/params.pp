class gsutil::params {
  case $::kernel {
    'linux': {
       $download_filename = 'gsutil.tar.gz'
       $download_source = "https://storage.googleapis.com/pub/${download_filename}"
       $install_dir = '/opt'
     }
     default: {fail("Kernel ${::kernel} not supported by module!")}
  }
}
