scriptname RFAB_LearnMapMarkers extends ObjectReference

Formlist[] Property MapMarkers Auto

Event onRead()
	int Markers = MapMarkers.length
	While (Markers > 0)
		Markers -= 1
		int size = MapMarkers[Markers].GetSize()
		While (size > 0)
			size -= 1
			ObjectReference Marker = MapMarkers[Markers].GetAt(size) As ObjectReference 
			Marker.AddToMap()
		endWhile
	endWhile
endEvent