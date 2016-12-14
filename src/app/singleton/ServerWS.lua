local NetWebSocket = class("NetWebSocket")

NetWebSocket.server_addr = "localhost:8088"
NetWebSocket.http_entry = "welcome";
NetWebSocket.websocket_entry = "welcome"


NetWebSocket.TEXT_MESSAGE = 0
NetWebSocket.BINARY_MESSAGE = 1
NetWebSocket.BINARY_ARRAY_MESSAGE = 2

NetWebSocket.OPEN_EVENT    = "open"
NetWebSocket.MESSAGE_EVENT = "message"
NetWebSocket.CLOSE_EVENT   = "close"
NetWebSocket.ERROR_EVENT   = "error"

function NetWebSocket:ctor()

end

function NetWebSocket:getInstance()
	if not self._instance then
		self._instance = self.new()
	end
	return self._instance
end


function NetWebSocket:onOpen(event)
	print("onOpen")
end

function NetWebSocket:onMessage(event)
	print("onMessage")
end

function NetWebSocket:onClose(event)
	print("onClose")
	self.websokcet = nil
end

function NetWebSocket:onError(event)
	print("onError")
	self.websokcet = nil
end

function NetWebSocket:connectServer(sid)
	local url = "ws://"..self.server_addr.."/"..self.http_entry.."/"
	self.websokcet = cc.WebSocket:createByAProtocol(url, "gbc-auth-"..sid)
	if self.websokcet then
		websocket:registerScriptHandler(handler(self, self.onOpen), cc.WEBSOCKET_OPEN)
		websocket:registerScriptHandler(handler(self, self.onMessage), cc.WEBSOCKET_MESSAGE)
		websocket:registerScriptHandler(handler(self, self.onClose), cc.WEBSOCKET_CLOSE)
		websocket:registerScriptHandler(handler(self, self.onError), cc.WEBSOCKET_ERROR)
	end

end

return NetWebSocket


