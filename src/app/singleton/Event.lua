local Event = {}
cc.EventProxy.new(Event)
cc(Event):addComponent("components.behavior.EventProtocol"):exportMethods()


function G_RegisterEvent(event_name, callback, tag)
	if Event:addEventListener(event_name, callback, tag) then
		return event_name
	end
end

function G_DispatchEvent(event_name, data)
	Event:dispatchEvent({name=event_name, data=data or {}})
end

function G_RemoveEvent(event_name)
	if Event:hasEventListener(event_name) then
		Event:removeEventListenersByEvent(event_name)
	end

end

function G_RemoveEvents(event_names)
	if event_names and type(event_names) == "table" then
		for i,v in ipairs(event_names) do
			removeEvent(v)
		end
	else
		printError("params is nil or not a table")
	end
end

	-- Event:dispatchEvent({name="Hello"})
	


-- addEventListener(eventName, listener, tag)
-- dispatchEvent(event)
-- removeEventListener(handleToRemove)
-- removeEventListenersByTag(tagToRemove)
-- removeEventListenersByEvent(eventName)
-- removeAllEventListeners()
-- hasEventListener(eventName)
-- dumpAllEventListeners()
-- exportMethods()
-- onBind_()
-- onUnbind_()
