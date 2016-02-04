# This file checks for operating system is based on linux Kernel
# If its linux Kernel, it assigns the gsutil package from google storage 
# as download_source parameter for init puppet file
class gsutil::params {
#Checks for linux Kernel
  case $::kernel {
    'linux': {
    $download_filename = 'gsutil.tar.gz'
    $download_source = "https://storage.googleapis.com/pub/${download_filename}"
    $install_dir = '/opt'
    }
  #Throws failure message for any other operating system
    default: {fail("Kernel ${::kernel} not supported by module!")}
  }
}
