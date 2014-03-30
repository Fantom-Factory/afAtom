using xml

** Contains, or links to, the content of an Atom `Entry`.
** 
** @see The [atom:content]`http://tools.ietf.org/html/rfc4287#section-4.1.3` Element
// TODO: allow content links, mime type and base64 content
class Content {
	
	private Text text
	
	** The most common case, where the content is identical to a text construct. 
	new make(Str content, TextType type := TextType.text, Uri? xmlBase := null, Str? xmlLang := null) {
		this.text			= Text(content, type)
		this.text.xmlBase	= xmlBase
		this.text.xmlLang	= xmlLang
	}
	
	internal XElem toXml() {
		content := text.toXml("content")
		
		return content
	}
}
