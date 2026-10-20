use std/assert
use bf-node


#======================================================================================================================
# paths
#======================================================================================================================

export def paths__run_file_is_in_live_directory [] {
    let paths = bf-node app paths

    assert equal "/app/live" $paths.live
    assert equal "/app/live/index.js" $paths.run
    assert ($paths.run | str starts-with $paths.live)
}


#======================================================================================================================
# default app
#======================================================================================================================

export def default_app__exists [] {
    assert ((bf-node app paths).run | path exists)
}

export def default_app__listens_on_all_interfaces [] {
    # listening on 127.0.0.1 would make the published port unreachable
    let source = open --raw (bf-node app paths).run

    assert ($source =~ "hostname = '0.0.0.0'")
    assert ($source =~ "port = 3000")
}

export def default_app__is_valid_javascript [] {
    let result = ^node --check (bf-node app paths).run | complete

    assert equal 0 $result.exit_code $result.stderr
}
