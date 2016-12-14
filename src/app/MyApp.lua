
require("config")
require("cocos.init")
require("framework.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")

    Event = require("app.singleton.Event"):getInstance()
    
    

    self:enterScene("MainScene")
end

return MyApp



-- require("config")
-- require("cocos.init")
-- require("framework.init")

-- local MyApp = class("MyApp", cc.mvc.AppBase)

-- function MyApp:ctor()
--     MyApp.super.ctor(self)
-- end

-- function MyApp:run()
--     cc.FileUtils:getInstance():addSearchPath("res/")

--     Event = require("app.singleton.Event"):getInstance()

--     -- G_RegisteEvent = Event:registeEvent


--     -- g_WebSocket = nil
    
--     -- require("app.Network")

--     -- G_ServerHttpPost("user.signin", {username = "ddsadf"}, function(response)
--     --     dump(response)
--     -- 	G_ServerWebSocket(response.sid)
--     -- end)

--     -- registerEvent("test", function()
--     -- 	print("hello")
--     -- end)

--     -- registerEvent("test", function()
--     -- 	print("hello")
--     -- end)

--     -- dispatchEvent("test")



--     self:enterScene("MainScene")
-- end

-- return MyApp
