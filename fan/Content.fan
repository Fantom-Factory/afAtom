
class Content {
	
	private Text text
	
	new make(Str content, TextType type := TextType.text, Uri? xmlBase := null) {
		this.text	= Text(content, type)
	}
}
