using xml

class Person {
	
	Str		name
	Uri?	uri
	Uri?	email
	
	new make(Str name) {
		this.name = name
	}
	
	XElem toXml(Str elementName) {
		person := XElem(elementName)
		
		person.add(XElem("name") {
			XText(this.name),
		})

		if (uri != null)
			person.add(XElem("uri") {
				XText(this.uri.toStr),
			})
		
		if (email != null)
			person.add(XElem("email") {
				XText(email.toStr),
			})
		
		return person
	}
}

