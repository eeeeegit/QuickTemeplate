local server_addr = "localhost:8088"
local http_entry = "welcome";
local websocket_entry = "welcome"


local function onRequestFinished_(event)
    local ok = (event.name == "completed")
    local request = event.request
 
    if not ok then
        -- 请求失败，显示错误代码和错误消息
        print(request:getErrorCode(), request:getErrorMessage())
        return
    end
 
    local code = request:getResponseStatusCode()
    if code ~= 200 then
        -- 请求结束，但没有返回 200 响应代码
        print(code)
        return
    end
 
    -- 请求成功，显示服务端返回的内容
    local response = request:getResponseString()
    print(response)
end
 

function G_HttpPost()

end

function G_ServerHttpPost(action, post_values, callback)
	
	local url = "http://"..server_addr.."/"..http_entry.."/?action="..action

	local request = network.createHTTPRequest(function(event)
		local ok = (event.name == "completed")
	    local request = event.request
	 
	    if not ok then
	        -- 请求失败，显示错误代码和错误消息
	        print(request:getErrorCode(), request:getErrorMessage())
	        return
	    end
	 
	    local code = request:getResponseStatusCode()
	    if code ~= 200 then
	        -- 请求结束，但没有返回 200 响应代码
	        print(code)
	        return
	    end
	 
	    -- 请求成功，显示服务端返回的内容
	    local response = request:getResponseString()
	    callback(json.decode(response))
	end, url, "POST")

	for k,v in pairs(post_values) do
		request:addPOSTValue(k,v)
	end

	request:start()
end

function G_ServerHttpGet()

end



-- -- websocket
function G_ServerWebSocket(sid)
	local WebSockets = class("WebSockets")
	WebSockets.TEXT_MESSAGE = 0
	WebSockets.BINARY_MESSAGE = 1
	WebSockets.BINARY_ARRAY_MESSAGE = 2

	WebSockets.OPEN_EVENT    = "open"
	WebSockets.MESSAGE_EVENT = "message"
	WebSockets.CLOSE_EVENT   = "close"
	WebSockets.ERROR_EVENT   = "error"


	local function onOpen(event)
	    print("connected")
	end

	local function onMessage(event)
		dump(event)
	    if WebSockets.BINARY_MESSAGE == event.messageType then
	        printf("receive binary msg: len = %s, binary = %s", string.len(event.message), bin2hex(event.message))
	    else
	        printf("receive text msg: %s", event.message)
	    end
	end

	local function onClose(event)
	    self.websocket = nil
	end

	local function onError(event)
	    printf("error %s", event.error)
	    self.websocket = nil
	end


	local url = "ws://"..server_addr.."/"..http_entry.."/"
	local websocket = cc.WebSocket:createByAProtocol(url, "gbc-auth-"..sid)

	if websocket then
	    websocket:registerScriptHandler(onOpen, cc.WEBSOCKET_OPEN)
	    websocket:registerScriptHandler(onMessage, cc.WEBSOCKET_MESSAGE)
	    websocket:registerScriptHandler(onClose, cc.WEBSOCKET_CLOSE)
	    websocket:registerScriptHandler(onError, cc.WEBSOCKET_ERROR)
	end
end

-- self.socket = cc.WebSocket:createByAProtocol(url,protocol)

-- if self.socket then
--     self.socket:registerScriptHandler(handler(self, self.onOpen_), cc.WEBSOCKET_OPEN)
--     self.socket:registerScriptHandler(handler(self, self.onMessage_), cc.WEBSOCKET_MESSAGE)
--     self.socket:registerScriptHandler(handler(self, self.onClose_), cc.WEBSOCKET_CLOSE)
--     self.socket:registerScriptHandler(handler(self, self.onError_), cc.WEBSOCKET_ERROR)
-- end

