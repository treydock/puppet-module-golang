# @summary Install Go
#
# Download and install Go programming language
#
# @example
#   include golang
#
# @param version
#   Version of Go to install
# @param os
#   The GOOS to install
# @param arch
#   The GOARCH to install
# @param download_dir
#   The directory of where to download Go
# @param extract_dir
#   The directory where to extract Go
# @param bin_dir
#   The path to bin directory for go and gofmt symlinks
class golang (
  String $version = '1.17.7',
  String[1] $os = downcase($facts['kernel']),
  String[1] $arch = $facts['os']['architecture'],
  Stdlib::Absolutepath $download_dir = '/tmp',
  Stdlib::Absolutepath $extract_dir = '/opt',
  Stdlib::Absolutepath $bin_dir = '/usr/bin',
) {

  if $os != 'linux' {
    fail("Module golang only supports Linux, not ${os}")
  }

  case $arch {
    'x86_64', 'amd64': { $real_arch = 'amd64' }
    'i386':            { $real_arch = '386'   }
    'aarch64':         { $real_arch = 'arm64' }
    'armv7l':          { $real_arch = 'armv7' }
    'armv6l':          { $real_arch = 'armv6' }
    'armv5l':          { $real_arch = 'armv5' }
    default:           { $real_arch = $arch }
  }

  $file = "go${version}.${os}-${real_arch}.tar.gz"
  $install_dir = "${extract_dir}/go-${version}"

  file { $install_dir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  archive { "${download_dir}/${file}":
    source          => "https://dl.google.com/go/${file}",
    extract         => true,
    extract_path    => $install_dir,
    extract_command => 'tar xfz %s --strip-components=1',
    creates         => "${install_dir}/bin/go",
    cleanup         => true,
    user            => 'root',
    group           => 'root',
    require         => File[$install_dir],
    before          => [
      File['go-binary'],
      File['gofmt-binary'],
    ]
  }

  file { 'go-binary':
    ensure => 'link',
    path   => "${bin_dir}/go",
    target => "${install_dir}/bin/go",
  }
  file { 'gofmt-binary':
    ensure => 'link',
    path   => "${bin_dir}/gofmt",
    target => "${install_dir}/bin/gofmt",
  }
}
