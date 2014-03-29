using xml

class Entry {
	
	Uri			id
	Text		title
	DateTime	updated
	
	Person[]	authors			:= Person[,]
	Content?	content		// warn - it may not be text!
	Link[]		links			:= Link[,]
	Text?		summary
	
	DateTime?	published
	Category[]	categories		:= Category[,]
	Person[]	contributors	:= Person[,]
//	Feed?		source		// must not have any Entry elements
	Text?		rights

	
	new make(Uri id, Text title, DateTime updated) {
		this.id			= id
		this.title		= title
		this.updated	= updated
	}
	
	XElem toXml() {
		entry := XElem("entry")
		
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
		
		if (content != null)
			entry.add(content.toXml)
		
		return entry
	}
}
