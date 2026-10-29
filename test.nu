#!/usr/bin/env -S nu -n

use ../index/test.nu

const node_branches = [
    "20"
    "21"
    "22"
    "23"
    "24"
    "26"
]

# Run test suite for image
def main [
    node: string = "24"     # define which Node.js version to use
    --all (-a)              # test all registered versions of Node.js (overrides $node)
] {
    let branches = if $all { $node_branches } else { [$node] }
    test "node" $branches
}
