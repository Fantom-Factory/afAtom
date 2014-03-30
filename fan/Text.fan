using xml

** Contains human-readable text.
** 
** @see The [Text]`http://tools.ietf.org/html/rfc4287#section-3.1` Construct
class Text {
	private static const XNs xmlNs	:= XNs("xml", ``)
	
	** *(Required)*
	** The human-readable text. This should not be XML escaped.
	Str			content
	
	** *(Required)*
	** Determines how the 'content' is encoded / escaped.
	TextType	type

	** *(Optional)* Used to control how relative URIs are resolved.
	Uri? xmlBase

	** *(Optional)* Used to identify the language of any human readable text.  
	Str? xmlLang

	** Creates a 'Text' with the required fields.
	** 
	** Note that 'content' should *not* be XML escaped in any way as this will be done 
	** automatically, dependent on the 'TextType' value.
	new make(Str content, TextType type := TextType.text) {
		this.content	= content
		this.type 		= type
	}
	
	internal XElem toXml(Str elementName) {
		text := XElem(elementName)

		if (xmlLang != null)
			text.addAttr("lang", xmlLang.toStr, xmlNs)

		if (xmlBase != null)
			text.addAttr("base", xmlBase.toStr, xmlNs)

		text.addAttr("type", type.toStr)
		
		text.add(type.escape(content))
		
		return text
	}
}

enum class TextType {
	
	** Denotes plain text with no entity escaped html.
	** 
	**   <title type="text">AT&amp;T bought by SBC!</title>
	text,
	
	** Denotes entity escaped html.
	** 
	**   <title type="html">
	**     AT&amp;amp;T bought &lt;b&gt;by SBC&lt;/b&gt;!
	**   </title>
	html,
	
	** Denotes inline xhtml, wrapped in a div element with an XHTML namespace.
	** 
	**   <title type="xhtml">
	**     <div xmlns="http://www.w3.org/1999/xhtml">
	**       AT&amp;T bought <b>by SBC</b>!
	**     </div>
	**   </title>
	xhtml;
	
	internal XNode escape(Str str) {
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
