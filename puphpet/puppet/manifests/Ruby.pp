class puphpet_ruby (
  $ruby
) {

  include '::gnupg'

  Class['::rvm']
  -> Puphpet::Ruby::Dotfile <| |>
  -> Puphpet::Ruby::Install <| |>
  -> Exec['rvm rvmrc warning ignore all.rvmrcs']

  class { '::rvm': }

  if ! defined(Group['rvm']) {
    group { 'rvm':
      ensure => present
    }
  }

  exec { 'rvm rvmrc warning ignore all.rvmrcs':
    command => 'rvm rvmrc warning ignore all.rvmrcs && touch /.puphpet-stuff/rvmrc',
    creates => '/.puphpet-stuff/rvmrc',
    path    => '/bin:/usr/bin:/usr/local/bin:/usr/local/rvm/bin',
    require => Exec['system-rvm'],
  }

  User <| title == $::ssh_username |> {
    groups +> 'rvm'
  }

  if array_true($ruby, 'versions') and count($ruby['versions']) > 0 {
    puphpet::ruby::dotfile { 'do': }

    create_resources(puphpet::ruby::install, $ruby['versions'])
  }

}
