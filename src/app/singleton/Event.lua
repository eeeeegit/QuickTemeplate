local Event = class("Event")

function Event:ctor()
	cc.EventProxy.new(Event)
	cc(Event):addComponent("components.behavior.EventProtocol"):exportMethods()
end

function Event:getInstance()
	if not self._instance then
		self._instance = self.new()
	end
	return self._instance
end

function Event:registeEvent(event_name, callback, tag)
	if self:addEventListener(event_name, callback, tag) then
		return event_name
	end
end

function Event:dispatchEvent(event_name, data)
	self:dispatchEvent({name=event_name, data=data or {}})
end

function Event:removeEvent(event_name)
	if self:hasEventListener(event_name) then
		self:removeEventListenersByEvent(event_name)
	end

end

function Event:removeEvents(event_names)
	if event_names and type(event_names) == "table" then
		for i,v in ipairs(event_names) do
			self:removeEvent(v)
		end
	else
		printError("params is nil or not a table")
	end
end

return Event
