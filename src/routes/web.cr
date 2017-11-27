# Matches GET "http://host:port/"
require "kilt/slang"

get "/" do
  render "src/views/pages/home.ecr", "src/views/layouts/main.ecr"
  # render "src/views/pages/home.slang"
end

SOCKETS = [] of HTTP::WebSocket
ws "/chat" do |socket|
  # Add the client to SOCKETS list
  SOCKETS << socket

  # Broadcast each message to all clients
  socket.on_message do |message|
    SOCKETS.each { |socket| socket.send message}
  end

  # Remove clients from the list when it's closed
  socket.on_close do
    SOCKETS.delete socket
  end
end
