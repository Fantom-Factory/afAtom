
class Text {
	
	TextType	type
	Str?		content
	
	new make(TextType type, Str content) {
		this.type 		= type
		this.content	= content
	}
}

enum class TextType {
	text,
	html,
	xhtml
}
