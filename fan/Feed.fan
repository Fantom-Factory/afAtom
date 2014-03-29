using xml

class Feed {

	Uri			id
	Text		title
	DateTime	updated
	
	Person[]	authors			:= Person[,]
	Link[]		links			:= Link[,]
	Entry[]		entries			:= Entry[,]
	
	Category[]	categories		:= Category[,]
	Person[]	contributors	:= Person[,]
	Uri?		icon
	Uri?		logo
	Text?		rights
	Text?		subtitle
	Generator?	generator
	
	new make(Uri id, Text title, DateTime updated) {
		this.id			= id
		this.title		= title
		this.updated	= updated
	}
	
	XDoc toXml() {
		feed := XElem("feed")
		feed.add(XAttr(XNs("", `http://www.w3.org/2005/Atom`)))

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

		entries.each {   
			feed.add(it.toXml)
		}
		
		return XDoc(feed)
	}
}
