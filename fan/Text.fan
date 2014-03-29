
class Text {
	
	TextType	type
	Str?		content
	
	new make(Str content, TextType type := TextType.text) {
		this.type 		= type
		this.content	= content
	}
}

enum class TextType {
	text,
	html,
	xhtml
}
