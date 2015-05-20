using xml

** Represents an Atom Entry Document.
** An example of an entry would be a single post on a weblog.
** 
** @see The [atom:entry]`http://tools.ietf.org/html/rfc4287#section-4.1.2` Element
class Entry {
	private static const XNs xmlNs	:= XNs("xml", ``)

	** *(Required)* 
	** Identifies the entry using a universally unique and permanent URI. 
	** Two entries in a feed can have the same value for id if they represent the same entry at 
	** different points in time.
	** 
	**   syntax: xml
	** 
	**   <id>http://example.com/blog/1234</id>
	Uri			id
	
	** *(Required)* 
	** Contains a human readable title for the entry. This value should not be blank.
	** 
	**   syntax: xml
	** 
	**   <title>Atom-Powered Robots Run Amok</title>
	Text		title

	** *(Required)* 
	** Indicates the last time the entry was modified in a significant way. 
	** This value need not change after a typo is fixed, only after a substantial modification. 
	** Generally, different entries in a feed will have different updated timestamps.
	** 
	**   syntax: xml
	** 
	**   <updated>2003-12-13T18:30:02-05:00</updated>
	DateTime	updated
	
	** *(Recommended)* 
	** Authors of the entry. An entry must contain at least one author element 
	** unless there is an author element in the enclosing feed, or there is an author element 
	** in the enclosed source element.
	** 
	**   syntax: xml
	** 
	**   <author>
	**     <name>John Doe</name>
	**   </author>
	Person[]	authors			:= Person[,]
	
	** *(Recommended)* 
	** Contains or links to the complete content of the entry. 
	** Content must be provided if there is no alternate link, and should be provided if there is 
	** no summary.
	** 
	**   syntax: xml
	** 
	**   <content type="text">complete story here</content>
	Content?	content
	
	** *(Recommended)* 
	** Identifies a related Web page. 
	** The type of relation is defined by the 'rel' attribute. 
	** An entry is limited to one 'alternate' per 'type' and 'hreflang'. 
	** An entry must contain an 'alternate' link if there is no content element.
	** 
	**   syntax: xml
	** 
	**   <link rel="alternate" href="/blog/1234"/>
	Link[]		links			:= Link[,]
	
	** *(Recommended)* 
	** Conveys a short summary, abstract, or excerpt of the entry. 
	** Summary should be provided if there either is no content provided for the entry, or that 
	** content is not inline (i.e., contains a 'src' attribute), or if the content is encoded in 
	** base64.
	** 
	**   syntax: xml
	** 
	**   <summary type="text">Some text.</summary>
	Text?		summary
	
	** *(Optional)* 
	** Contains the time of the initial creation or first availability of the entry.
	** 
	**   syntax: xml
	** 
	**   <published>2003-12-13T09:17:51-08:00</published>
	DateTime?	published
	
	** *(Optional)* 
	** Specifies categories that the entry belongs to.
	** 
	**   <category term="technology"/>
	Category[]	categories		:= Category[,]
	
	** *(Optional)* 
	** Contributors to the entry.
	** 
	**   syntax: xml
	** 
	**   <contributor>
	**     <name>Jane Doe</name>
	**   </contributor>
	Person[]	contributors	:= Person[,]
	
	** *(Optional)* 
	** If an entry is copied from one feed into another feed, then the source feed‘s metadata (all 
	** child elements of feed other than the entry elements) should be preserved if the source feed 
	** contains any of the child elements 'author', 'contributor', 'rights', or 'category' and 
	** those child elements are not present in the source entry.
	** 
	**   syntax: xml
	** 
	**   <source>
	**     <id>http://example.org/</id>
	**     <title>Fourty-Two</title>
	**     <updated>2003-12-13T18:30:02Z</updated>
	**     <rights>© 2005 Example, Inc.</rights>
	**   </source>
	Feed?		source
	
	** *(Optional)* 
	** Conveys information about rights, e.g. copyrights, held in and over the entry.
	** 
	**   syntax: xml
	** 
	**   <rights type="html">
	**     &amp;copy; 2005 John Doe
	**   </rights>
	Text?		rights

	** *(Optional)* 
	** Used to control how relative URIs are resolved.
	Uri? xmlBase

	** *(Optional)* 
	** Used to identify the language of any human readable text.  
	Str? xmlLang

	** Creates an 'Entry' with the required fields.
	new make(Uri id, Text title, DateTime updated) {
		this.id			= id
		this.title		= title
		this.updated	= updated
	}

	** Creates an '<entry>' element.
	virtual XElem toXml() {
		entry := XElem("entry")
		
		if (xmlLang != null)
			entry.addAttr("lang", xmlLang.toStr, xmlNs)

		if (xmlBase != null)
			entry.addAttr("base", xmlBase.toStr, xmlNs)
		
		entry.add(XElem("id") {
			XText(id.toStr),
		})		

		entry.add(title.toXml("title"))

		if (published != null)
			entry.add(XElem("published") {
				XText(published.toIso),
			})
		
		entry.add(XElem("updated") {
			XText(updated.toIso),
		})
		
		authors.each { 
			entry.add(it.toXml("author"))
		}
		
		links.each {
			entry.add(it.toXml)
		}
		
		if (summary != null)
			entry.add(summary.toXml("summary"))

		categories.each {
			entry.add(it.toXml)
		}
		
		contributors.each {
			entry.add(it.toXml("contributor"))
		}
		
		if (rights != null)
			entry.add(rights.toXml("rights"))
		
		if (source != null)
			entry.add(source.addMetaData(XElem("source")))
		
		if (content != null)
			entry.add(content.toXml)
		
		return entry
	}
}
