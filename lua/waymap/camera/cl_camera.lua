Waymap.Camera = Waymap.Camera or {}
Waymap.Camera.callbackID = 0
Waymap.Camera.callbacks = Waymap.Camera.callbacks or {}

function Waymap.Camera.RequestFromServer(callback)
	Waymap.Camera.callbackID = Waymap.Camera.callbackID + 1
	Waymap.Camera.callbacks[Waymap.Camera.callbackID] = callback
	
	net.Start("Waymap.Camera.ServerRequestCamera")
	net.WriteFloat(Waymap.Camera.callbackID)
	net.SendToServer()
end

function Waymap.Camera.SaveCameraToServer(camera)
	net.Start("Waymap.Camera.ServerSaveCamera")
	net.WriteTable(camera)
	net.SendToServer()
end

net.Receive("Waymap.Camera.ClientSendCamera", function(ply)
	local callbackID = net.ReadFloat()
	local camera = net.ReadTable()
	
	Waymap.Camera.callbacks[callbackID](camera)
	Waymap.Camera.callbacks[callbackID] = nil
end)