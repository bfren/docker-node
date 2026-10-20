use bf
use bf-node
bf env load

# Set environment variables
def main [] {
    # app directories and run file
    let paths = bf-node app paths
    bf env set NODE_APP $paths.app
    bf env set NODE_APP_LIVE $paths.live
    bf env set NODE_APP_PUBLISH $paths.publish
    bf env set NODE_RUN $paths.run

    # return nothing
    return
}
