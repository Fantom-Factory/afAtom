//using afAtom

internal class Example {
	Void main() {

		// create a feed...
		feed := Feed(`example:feed`, Text("Fantom Feed"), DateTime.now)
		feed.links.add(Link(`http://www.fantomfactory.org/`, "alternate") {
			it.title	= "Fantom-Factory"
			it.type		= MimeType("application/xhtml+xml")
		})

		// add entries...
		text := "<p>Visit the <b>Atom</b> homepage to find out moar!</p>"
		entry := Entry(`example:afAtom:`, Text("Atom Released!"), DateTime.now)		
		entry.content = Content(text, TextType.html)		
		feed.entries.add(entry)
		
		// convert to XML...
		atomXml := feed.toXml.writeToStr
		echo(atomXml)
	}
}
