var PORT = 33333;
var HOST = '0.0.0.0';

var dgram = require('dgram');
var message = new Buffer('Data Insights Rocks!');

var client = dgram.createSocket('udp4');
client.send(message, 0, message.length, PORT, HOST, function(err, bytes) {
  if (err) throw err;
  console.log('UDP message sent to ' + HOST +':'+ PORT);
  client.close();
});