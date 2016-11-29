local NetHttp = {}
NetHttp.server_addr = "localhost:8088"
NetHttp.http_entry = "welcome";
NetHttp.websocket_entry = "welcome"

function NetHttp:ServerGet(action, post_values, callback)

	local url = "http://"..self.server_addr.."/"..self.http_entry.."/?action="..action

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

return NetHttp









-- -- local function onRequestFinished_(event)
-- --     local ok = (event.name == "completed")
-- --     local request = event.request
 
-- --     if not ok then
-- --         -- 请求失败，显示错误代码和错误消息
-- --         print(request:getErrorCode(), request:getErrorMessage())
-- --         return
-- --     end
 
-- --     local code = request:getResponseStatusCode()
-- --     if code ~= 200 then
-- --         -- 请求结束，但没有返回 200 响应代码
-- --         print(code)
-- --         return
-- --     end
 
-- --     -- 请求成功，显示服务端返回的内容
-- --     local response = request:getResponseString()
-- --     print(response)
-- -- end
 

-- function G_HttpPost()

-- end

-- function G_ServerHttpPost(action, post_values, callback)
	
-- 	local url = "http://"..server_addr.."/"..http_entry.."/?action="..action

-- 	local request = network.createHTTPRequest(function(event)
-- 		local ok = (event.name == "completed")
-- 	    local request = event.request
	 
-- 	    if not ok then
-- 	        -- 请求失败，显示错误代码和错误消息
-- 	        print(request:getErrorCode(), request:getErrorMessage())
-- 	        return
-- 	    end
	 
-- 	    local code = request:getResponseStatusCode()
-- 	    if code ~= 200 then
-- 	        -- 请求结束，但没有返回 200 响应代码
-- 	        print(code)
-- 	        return
-- 	    end
	 
-- 	    -- 请求成功，显示服务端返回的内容
-- 	    local response = request:getResponseString()
-- 	    callback(json.decode(response))
-- 	end, url, "POST")

-- 	for k,v in pairs(post_values) do
-- 		request:addPOSTValue(k,v)
-- 	end

-- 	request:start()
-- end

-- function G_ServerHttpGet()

-- end


