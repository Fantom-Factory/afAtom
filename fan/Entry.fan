
class Entry {
	
	Uri			id
	Str			title
	DateTime	updated
	
	Person?		author
	Text?		content		// may not be text
	Link?		link
	Text?		summary
	
	Category[]	categories		:= Category[,]
	Person[]	contributors	:= Person[,]
	DateTime?	published
	Feed?		source		// must not have any Entry elements
	Text?		rights

	
	new make(Uri id, Str title, DateTime updated) {
		this.id			= id
		this.title		= title
		this.updated	= updated
	}
}
