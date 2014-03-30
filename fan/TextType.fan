using xml

** Determines how `Text` content is encoded / escaped.
** 
** @see The [Type]`http://tools.ietf.org/html/rfc4287#section-3.1.1` Attribute
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
			div.add(Utils.parseXml(str))
			return div
		}
		throw Err("WTF is a ${this}?")
	}
}
