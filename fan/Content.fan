using xml

** Contains, or links to, the content of an Atom `Entry`.
** 
** @see The [atom:content]`http://tools.ietf.org/html/rfc4287#section-4.1.3` Element
class Content {
	private static const XNs xmlNs	:= XNs("xml", ``)

	** *(Optional)* 
	** Used to control how relative URIs are resolved.
	Uri? xmlBase

	** *(Optional)* 
	** Used to identify the language of any human readable text.  
	Str? xmlLang
	
	private Str? 		content
	private TextType?	textType
	private MimeType?	mimeType
	private Uri?		src
	private InStream?	binary
	
	** The most common case, where the content is identical to a text construct. 
	new makeFromText(Str content, TextType type := TextType.text) {
		this.content	= content
		this.textType	= type
	}

	** Similar to text.
	** If the given 'type' ends in '+xml' or '/xml' then the XML is contained inline (like XHTML).
	** If the given 'type' starts with 'text' the content is XML escaped (like HTML).
	** Otherwise the content is Base64 encoded.
	new makeFromStr(Str content, MimeType type) {
		this.content	= content
		this.mimeType	= type
	}

	** The given 'src' represents the URI of where the content can be found.
	new makeFromSrc(Uri src, MimeType? type := null) {
		this.src		= src
		this.mimeType	= type
	}

	** The content is Base64 encoded.
	new makeFromBinary(InStream binaryContent, MimeType type) {
		this.binary		= binaryContent
		this.mimeType	= type
	}
	
	** Creates a '<content>' element.
	virtual XElem toXml() {
		// from Text
		if (this.content != null && textType != null) {
			return Text(this.content, textType) {
				it.xmlLang = this.xmlLang
				it.xmlBase = this.xmlBase
			}.toXml("content")
		}

		content := XElem("content")
		
		if (xmlLang != null)
			content.addAttr("lang", xmlLang.toStr, xmlNs)
		
		if (xmlBase != null)
			content.addAttr("base", xmlBase.toStr, xmlNs)
		
		// from Str
		if (this.content != null && mimeType != null) {
			// FUTURE: Fantom 1.0.66 - use MimeType.noParams()  
			mime := "${mimeType.mediaType}/${mimeType.subType}"  
			content.addAttr("type", mimeType.toStr)
			
			if (mime.endsWith("+xml") || mime.endsWith("/xml")) {
				content.add(Utils.parseXml(this.content))					
			}

			else if (mime.startsWith("text")) {
				content.add(XText(this.content))
			}
			
			else {
				content.add(XText(this.content.toBuf.toBase64))				
			}
		}
		
		// from Src
		if (src != null) {
			content.addAttr("src", src.toStr)
			
			if (mimeType != null)
				content.addAttr("type", mimeType.toStr)
		}
		
		// from Binary
		if (binary != null && mimeType != null) {
			content.addAttr("type", mimeType.toStr)

			content.add(XText(this.binary.readAllBuf.toBase64))				
		}

		return content
	}
}
