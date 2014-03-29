using xml

class Link {
	
	Uri			href
	Str?		rel
	MimeType?	type
	Str?		hreflang
	Str?		title
	Int?		length
	
	new make(Uri href) {
		this.href = href
	}

	XElem toXml() {
		link := XElem("link")
		
		link.addAttr("href", href.toStr)

		if (rel != null)
			link.addAttr("rel", rel)

		if (type != null)
			link.addAttr("type", type.toStr)

		if (hreflang != null)
			link.addAttr("hreflang", hreflang)

		if (title != null)
			link.addAttr("title", title)

		if (length != null)
			link.addAttr("length", length.toStr)

		return link
	}
}
