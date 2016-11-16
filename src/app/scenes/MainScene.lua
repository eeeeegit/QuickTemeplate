
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    cc.ui.UILabel.new({
            UILabelType = 2, text = "Hello, World", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)

    cc.ui.UIPushButton.new()
        :setButtonLabel(cc.ui.UILabel.new({text = "connect", size = 32}))
        :onButtonClicked(function()
            print("hello")
        end)
        :align(display.CENTER, display.cx, display.cy - 32)
        :addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
