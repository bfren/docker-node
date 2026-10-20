use std/assert
use bf


#======================================================================================================================
# installation
#======================================================================================================================

export def install__node_user_has_uid_1000 [] {
    assert equal "1000" (^id -u node | str trim)
    assert equal "1000" (^id -g node | str trim)
}

export def install__node_matches_build [] {
    let build = with-env {BF_ETC: "/etc/bf"} { bf build | get "Node.js" }
    let installed = ^node --version | str trim | str replace "v" ""

    assert ($build | str starts-with $installed) $"Node.js ($installed) should match the build ($build)"
}

export def install__npm_matches_build [] {
    let build = with-env {BF_ETC: "/etc/bf"} { bf build | get NPM }
    let installed = ^npm --version | str trim

    assert ($build | str starts-with $installed) $"NPM ($installed) should match the build ($build)"
}

export def install__versions_are_saved_for_startup [] {
    assert ((open --raw /etc/bf/INIT_VERSIONS) =~ '^Node\.js v\d+\.\d+\.\d+ installed with NPM \d+\.\d+\.\d+\.$')
}


#======================================================================================================================
# service
#======================================================================================================================

export def service__scripts_parse [] {
    for x in [run finish] {
        let path = $"/etc/s6-overlay/s6-rc.d/node/($x)"
        let result = ^$nu.current-exe --no-config-file --commands $"nu-check ($path)" | complete
        assert equal "true" ($result.stdout | str trim) $"($x) does not parse: ($result.stderr)"
    }
}
