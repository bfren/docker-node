// Import http module
var http = require( 'http' );

// Create server to return welcome message
http
    .createServer(
        function( req, res ) {
            res.writeHead( 200, { 'Content-Type': 'text/html' } );
            res.write( '<!DOCTYPE html><html>' );
            res.write( '<head><title>Welcome</title><style type="text/css">* { font-family: Arial, sans-serif; }</style></head>' );
            res.write( '<body><p>Welcome to Node.</p></body>' );
            res.end( '</html>' );
        }
    )
    .listen(
        3000
    );
