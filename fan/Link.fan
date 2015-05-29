using xml

** Defines a reference from an entry or feed to a Web resource. 
** 'Link' is patterned after html’s [link]`http://www.w3.org/TR/1999/REC-html401-19991224/struct/links.html#h-12.3` element.
** 
** @see The [atom:link]`http://tools.ietf.org/html/rfc4287#section-4.2.7` Element
class Link {
	
	** *(Required)*
	** The URI of the referenced resource (typically a Web page).
	Uri			href
	
	** *(Required)* 
	** Contains the relationship type. It can be a full URI, or one of the following predefined values:
	**  - 'alternate': an alternate representation of the entry or feed, for example a permalink to the html version of the entry, or the front page of the weblog.
	**  - 'enclosure': a related resource which is potentially large in size and might require special handling, for example an audio or video recording.
	**  - 'related': an document related to the entry or feed.
	**  - 'self': the feed itself.
	**  - 'via': the source of the information provided in the entry.
	Str		rel
	
	** *(Optional)* 
	** Indicates the media type of the resource.
	MimeType?	type
	
	** *(Optional)* 
	** Indicates the language of the referenced resource.
	Str?		hreflang
	
	** *(Optional)* 
	** Human readable information about the link, typically for display purposes.
	Str?		title
	
	** *(Optional)* 
	** The length of the resource, in bytes.
	Int?		length
	
	** Creates a 'Link' with the required fields.
	new make(Uri href, Str rel := "alternate") {
		this.href	= href
		this.rel 	= rel
	}

	** Creates a '<link>' element.
	virtual XElem toXml() {
		link := XElem("link")
		
		link.addAttr("href", href.encode)

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
