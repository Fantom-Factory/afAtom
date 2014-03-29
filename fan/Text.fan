using xml

class Text {
	
	TextType	type
	Str?		content
	
	new make(Str content, TextType type := TextType.text) {
		this.content	= content
		this.type 		= type
	}
	
	XElem toXml(Str elementName) {
		text := XElem(elementName)
		
		text.addAttr("type", type.toStr)
		
		if (content != null)
			text.add(type.escape(content))
		
		return text
	}
}

enum class TextType {
	text,
	html,
	xhtml;
	
	XNode escape(Str str) {
		if (this == text)
			return XText(str)
		if (this == html)
			return XText(str)
		if (this == xhtml) {
			div := XElem("div")
			div.add(XAttr(XNs("", `http://www.w3.org/1999/xhtml`)))
			parser := XParser(str.in)
			parser.next
			div.add(parser.parseElem)
			return div
		}
		throw Err("WTF is a ${this}?")
	}
}
