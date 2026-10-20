# Paths used to run the Node.js app
export def paths []: nothing -> record {
    let app = "/app"
    let live = $"($app)/live"
    {
        app: $app
        live: $live
        publish: $"($app)/publish"
        run: $"($live)/index.js"
    }
}
