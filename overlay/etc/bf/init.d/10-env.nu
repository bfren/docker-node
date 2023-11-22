use bf
bf env load

# Set environment variables
def main [] {
    # app directories
    let app = "/app"
    let app_live = $"($app)/live"
    bf env set NODE_APP $app
    bf env set NODE_APP_LIVE $app_live
    bf env set NODE_APP_PUBLISH $"($app)/publish"

    # run file
    bf env set NODE_RUN $"($app_live)/index.js"

    # return nothing
    return
}
