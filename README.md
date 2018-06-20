# docker-koferta
Repository for docker image configuration for koferta CI

## Ubuntu Branch
Based on Ubuntu latest (Bionic at the moment)

### PPAs added
 * beineri/opt-qt-5.11.0-bionic

### Packages installed from apt
 * build essentials
 * ninja build system
 * qt5: base, tools, mysql driver, image formats plugin
 * git
 * wget, sudo, pkg-config

### Packages installed manually
 * cmake

### Environment
 * User: user
 * Workdir: /home/user
