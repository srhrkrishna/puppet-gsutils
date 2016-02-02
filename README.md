## Overview

 Gsutil puppet module installs, configures gsutils to access Google cloud through command line.

## Module Description

 Gsutil puppet module helps the users to install the gsutil utility automatically in puppet agent using the manifest configured in puppet master, avoids human intervention and hassle free installation of the this command line utility to access the Google cloud

## Setup

1.Create a puppet manifest in the puppet master.

2.Include the gsutil package inside the manifest.
 
  ```sh
         include gsutil
  ```

3.Retrieve the catalog changes from puppet agent in case if its manually configured or wait for the runtime interval configured in case if its automatically configured.
  ```sh
         puppet agent -t -d
  ```
4.Restart the shell or terminal after gsutil package is installed. This will enable the path of gsutil in the default environment path variable.

5.Alternatively, you can source Link the install_gsutil.sh by executing the following command or export the path to configure gsutil to work without restarting the shell.

  ```sh
        source /etc/profile.d/install_gsutil.sh
  ```

  ```sh
        export PATH=$PATH:/opt/gsutil
  ```

## Limitations
Tested on CentOS6. To be tested on other flavors.

## Authors
This module is based on work by Gobu Natarajan, Sree Hari Krishna and Ram Vittal.

## Development
Interested contributors can touch base with Gobu (gobu.natarajan@gmail.com) or Ram Vittal (ramvittal@gmail.com)
