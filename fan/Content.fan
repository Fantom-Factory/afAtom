using xml

class Content {
	
	private Text text
	Uri? xmlBase
	Str? xmlLang
	
	new make(Str content, TextType type := TextType.text, Uri? xmlBase := null) {
		this.text		= Text(content, type)
		this.xmlBase	= xmlBase
	}
	
	XElem toXml() {
		content := text.toXml("content")
		xmlNs	:= XNs("xml", ``)
		
		if (xmlLang != null)
			content.addAttr("lang", xmlLang.toStr, xmlNs)

		if (xmlBase != null)
			content.addAttr("base", xmlBase.toStr, xmlNs)
		
		return content
	}
}
