const express = require('express')
const app = express()
const port = 3000

var mqtt = require('mqtt')
var client  = mqtt.connect('mqtt://localhost')

app.get('/', (req, res) => {
        client.publish('topic/test', 'Express Hello World')
        res.send('Hello World!')
})

app.get('/:key', (req, res) => {
     client.publish('topic/test', req.params.key)
     res.send(req.params)
})


app.listen(port, () => console.log(`Example app listening on port ${port}!`))