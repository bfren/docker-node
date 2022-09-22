// Import http module
const http = require('http');

// Hosting values
const hostname = '127.0.0.1';
const port = process.env.NODE_PORT;

// Create server
const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.write('<!DOCTYPE html><html>');
    res.write('<head><title>Welcome</title><style type="text/css">* { font-family: Arial, sans-serif; }</style></head>');
    res.write('<body><p>Welcome to Node.js.</p></body>');
    res.end('</html>');
});

// Listen to specified address
server.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
});
