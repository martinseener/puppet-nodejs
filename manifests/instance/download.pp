# = Define: nodejs::install::download
#
# == Parameters:
#
# [*source*]
#   Source to fetch for wget.
#
# [*destination*]
#   Local destination of the file to download.
#
# [*unless_test*]
#   Test whether the destination is already in use.
#
# [*timeout*]
#   Timeout for the download command.
#
define nodejs::instance::download(
  String $source,
  String $destination,
  Boolean $unless_test = true,
  Integer $timeout     = 0
) {
  if $caller_module_name != $module_name {
    warning('::nodejs::install::download is not meant for public use!')
  }

  $creates = $unless_test ? {
    true    => $destination,
    default => undef,
  }

  exec { "nodejs-wget-download-${source}-${destination}":
    command => "/usr/bin/wget --output-document ${destination} ${source}",
    creates => $creates,
    timeout => $timeout,
    require => [
      Package['wget'],
    ],
  }
}
