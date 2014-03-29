using xml

class Generator {
	
	Str		name
	Uri?	uri
	Str?	version
	
	new make(Str name) {
		this.name = name
	}
	
	XElem toXml() {
		generator := XElem("generator")
		
		if (uri != null)
			generator.addAttr("uri", uri.toStr)
		
		if (version != null)
			generator.addAttr("version", version)

		generator.add(XText(name))
		
		return generator
	}
}
