const express = require('express');
const app = express();


app.set('view engine', 'ejs');
app.use(express.static('public'))

app.get('/', (req, res) => {
    res.send('Hello World')
})


server = app.listen(3005);
const io = require("socket.io")(server);
io.on('connection', (socket) => {
    console.log("New connection");
    socket.on("new_user", (username) => {
        console.log(`connected to ${username}`)
    });
    socket.on("send_message", msg => {
        io.sockets.emit("new_message", msg)
    });
});
