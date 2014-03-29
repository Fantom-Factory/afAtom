using xml

class Category {
	
	Str		term
	Uri?	scheme
	Str?	label
	
	new make(Str term) {
		this.term = term
	}
	
	XElem toXml() {
		category := XElem("category")
		
		category.addAttr("term", term)
		
		if (scheme != null)
			category.addAttr("scheme", scheme.toStr)

		if (label != null)
			category.addAttr("label", label)
		
		return category
	}
}
