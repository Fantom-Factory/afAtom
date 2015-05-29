using xml

** Identifies the software used to generate the feed. Used for debugging and other purposes.
** 
** @see The [atom:generator]`http://tools.ietf.org/html/rfc4287#section-4.2.4` Element
class Generator {
	
	** *(Required)*
	** The name of the generator.
	Str		name
	
	** *(Optional)* 
	** The URI of the generator.
	Uri?	uri
	
	** *(Optional)* 
	** The version of the generator.
	Str?	version
	
	** Creates a 'Generator' with the required fields.
	new make(Str name) {
		this.name = name
	}
	
	** Creates a '<generator>' element.
	virtual XElem toXml() {
		generator := XElem("generator")
		
		if (uri != null)
			generator.addAttr("uri", uri.encode)
		
		if (version != null)
			generator.addAttr("version", version)

		generator.add(XText(name))
		
		return generator
	}
}
