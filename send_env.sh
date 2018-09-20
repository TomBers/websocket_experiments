#!/bin/bash
echo $QUERY_STRING
export HOME="/Users/tomberman"
start_websocket="mix run -e SendToSocket.loop"
$start_websocket
