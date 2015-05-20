using xml

** Represents the top-level Atom Feed Document.
** 
** @see The [atom:feed]`http://tools.ietf.org/html/rfc4287#section-4.1.1` Element
class Feed {
	private static const XNs xmlNs	:= XNs("xml", ``)

	** *(Required)* 
	** Identifies the feed using a universally unique and permanent URI. If you have a long-term, 
	** renewable lease on your Internet domain name, then you can feel free to use your website’s 
	** address.
	** 
	**   syntax: xml
	** 
	**   <id>http://example.com/</id>
	Uri			id
	
	** *(Required)* 
	** A human readable title for the feed. Often the same as the title of the associated website. 
	** This value should not be blank.
	** 
	**   syntax: xml
	** 
	**   <title>Example, Inc.</title>
	Text		title
	
	** *(Required)* Indicates the last time the feed was modified in a significant way.
	** 
	**   syntax: xml
	**   <updated>2003-12-13T18:30:02Z</updated>
	DateTime	updated
	
	** *(Recommended)* 
	** Authors of the feed. A feed must contain at least one author element unless all of the entry 
	** elements contain at least one author element.
	** 
	**   syntax: xml
	** 
	**   <author>
	**     <name>John Doe</name>
	**     <email>JohnDoe@example.com</email>
	**     <uri>http://example.com/~johndoe</uri>
	**   </author>
	Person[]	authors			:= Person[,]

	** *(Recommended)* 
	** Identifies a related Web page. The type of relation is defined by the 'rel' attribute. 
	** A feed is limited to one 'alternate' per 'type' and 'hreflang'. A feed should contain a link 
	** back to the feed itself.
	** 
	**   syntax: xml
	** 
	**   <link rel="self" href="http://example.com/feed" />
	Link[]		links			:= Link[,]
	
	** *(Recommended)* 
	** Entries of the feed.
	Entry[]		entries			:= Entry[,]
	
	** *(Optional)* 
	** Specifies a category that the feed belongs to.
	** 
	**   syntax: xml
	** 
	**   <category term="sports"/>
	Category[]	categories		:= Category[,]
	
	** *(Optional)* 
	** Contributors to the feed.
	** 
	**   syntax: xml
	** 
	**   <contributor>
	**     <name>Jane Doe</name>
	**   </contributor>
	Person[]	contributors	:= Person[,]
	
	** *(Optional)* 
	** Identifies a small image which provides iconic visual identification for the feed. 
	** Icons should be square.
	** 
	**   syntax: xml
	** 
	**   <icon>/icon.jpg</icon>
	Uri?		icon
	
	** *(Optional)* 
	** Identifies a larger image which provides visual identification for the feed.
	** Images should be twice as wide as they are tall.
	** 
	**   syntax: xml
	** 
	**   <logo>/logo.jpg</logo>
	Uri?		logo
	
	** *(Optional)* 
	** Conveys information about rights, e.g. copyrights, held in and over the feed.
	** 
	**   syntax: xml
	** 
	**   <rights> © 2005 John Doe </rights>
	Text?		rights
	
	** *(Optional)* 
	** Contains a human-readable description or subtitle for the feed.
	** 
	**   syntax: xml
	** 
	**   <subtitle type="text">all your examples are belong to us</subtitle>
	Text?		subtitle
	
	** *(Optional)* 
	** Identifies the software used to generate the feed, for debugging and other purposes.
	** 
	**   syntax: xml
	** 
	**   <generator uri="/myblog.php" version="1.0">
	**     Example Toolkit
	**   </generator>
	Generator?	generator
	
	** *(Optional)* 
	** Used to control how relative URIs are resolved.
	Uri? xmlBase

	** *(Optional)* 
	** Used to identify the language of any human readable text.  
	Str? xmlLang

	
	
	** Creates a 'Feed' with the required fields.
	new make(Uri id, Text title, DateTime updated) {
		this.id			= id
		this.title		= title
		this.updated	= updated
	}


	
	** Serialises the Atom feed to an XML document.
	XDoc toXml() {
		feed := XElem("feed")
		feed.add(XAttr(XNs("", `http://www.w3.org/2005/Atom`)))

		addMetaData(feed)
		
		entries.each {   
			feed.add(it.toXml)
		}
		
		return XDoc(feed)
	}
	
	internal XElem addMetaData(XElem feed) {
		if (xmlLang != null)
			feed.addAttr("lang", xmlLang.toStr, xmlNs)

		if (xmlBase != null)
			feed.addAttr("base", xmlBase.toStr, xmlNs)

		feed.add(XElem("id") {
			XText(id.toStr),
		})		

		feed.add(title.toXml("title"))

		if (subtitle != null)
			feed.add(subtitle.toXml("subtitle"))
		
		feed.add(XElem("updated") {
			XText(updated.toIso),
		})
		
		authors.each { 
			feed.add(it.toXml("author"))
		}
		
		links.each {
			feed.add(it.toXml)
		}
		
		categories.each {
			feed.add(it.toXml)
		}
		
		contributors.each {
			feed.add(it.toXml("contributor"))
		}
		
		if (icon != null)
			feed.add(XElem("icon") {
				XText(icon.toStr),
			})

		if (logo != null)
			feed.add(XElem("logo") {
				XText(logo.toStr),
			})

		if (rights != null)
			feed.add(rights.toXml("rights"))

		if (generator != null)
			feed.add(generator.toXml)
		
		return feed
	}
}
