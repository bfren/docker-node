use bf
bf env load

# Output Node.js versions
def main [] {
    # output contents of version file
    bf write (bf fs read $"(bf env ETC)/INIT_VERSIONS")

    # return nothing
    return
}
