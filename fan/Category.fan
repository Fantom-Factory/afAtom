using xml

** Conveys information about a category associated with an `Entry` or `Feed`.
** 
** The [atom:category]`http://tools.ietf.org/html/rfc4287#section-4.2.2` Element
class Category {
	
	** *(Required)* 
	** Identifies the category.
	Str		term
	
	** *(Optional)*
	** Identifies the categorization scheme via a URI.
	Uri?	scheme
	
	** *(Optional)*
	** Provides a human-readable label for display.
	Str?	label

	** Creates a 'Category' with the required fields.
	new make(Str term) {
		this.term = term
	}
	
	internal XElem toXml() {
		category := XElem("category")
		
		category.addAttr("term", term)
		
		if (scheme != null)
			category.addAttr("scheme", scheme.toStr)

		if (label != null)
			category.addAttr("label", label)
		
		return category
	}
}
