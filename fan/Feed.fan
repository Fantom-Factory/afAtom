using xml

class Feed {

	Uri			id
	Text		title
	DateTime	updated
	
	Person?		author
	Link?		link
	
	Category[]	categories		:= Category[,]
	Person[]	contributors	:= Person[,]
	Generator?	generator
	Uri?		icon
	Uri?		logo
	Text?		rights
	Text?		subtitle
	
	
	new make(Uri id, Str title, DateTime updated) {
		this.id			= id
		this.title		= Text(title)
		this.updated	= updated
	}
	
	XElem toXml() {
		feed := XElem("feed")
		
		return feed
	}
}
