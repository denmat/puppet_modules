
stage { repos: before  => Stage['first'] }
stage { first: before  => Stage['main'] }
stage { last:  require => Stage['main'] }


