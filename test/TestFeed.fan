using xml

class TestFeed : AtomTest {
	
	Void test() {		
		feed := Feed(`tag:example.org,2003:3`, Text("dive into mark"), DateTime.fromIso("2005-07-31T12:29:29Z"))
		feed.subtitle = Text("A <em>lot</em> of effort went into making this effortless", TextType.html)
		feed.links.add(Link(`http://example.org/`) {
			it.rel 		= "alternate"
			it.type		= MimeType("text/html")
			it.hreflang	= "en"
		})
		feed.links.add(Link(`http://example.org/feed.atom`) {
			it.rel 		= "self"
			it.type		= MimeType("application/atom+xml")
		})
		feed.rights	= Text("Copyright (c) 2003, Mark Pilgrim")
		feed.generator	= Generator("Example Toolkit") {
			it.uri		= `http://www.example.com/`
			it.version	= "1.0"
		}
		entry := Entry(`tag:example.org,2003:3.2397`, Text("Atom draft-07 snapshot"), DateTime.fromIso("2005-07-31T12:29:29Z"))
		entry.published	= DateTime.fromIso("2003-12-13T08:29:29-04:00")
		entry.authors.add(Person("Mark Pilgrim") {
			it.uri		= `http://example.org/`
			it.email	= `f8dy@example.com`
		})
		entry.links.add(Link(`http://example.org/2005/04/02/atom`) {
			it.rel 		= "alternate"
			it.type		= MimeType("text/html")
		})
		entry.links.add(Link(`http://example.org/audio/ph34r_my_podcast.mp3`) {
			it.rel 		= "enclosure"
			it.type		= MimeType("audio/mpeg")
			it.length	= 1337
		})
		entry.contributors.add(Person("Sam Ruby"))
		entry.contributors.add(Person("Joe Gregorio"))
		entry.content	= Content("<p><i>[Update: The Atom draft is finished.]</i></p>", TextType.xhtml, `http://diveintomark.org/`) {
			it.xmlLang	= "en" 
		}
		feed.entries.add(entry)


		feedXml := feed.toXml.writeToStr.trim.splitLines		
		testXml := `test/atom-feed.xml`.toFile.readAllStr.trim.splitLines

		Env.cur.err.printLine(feed.toXml.writeToStr)

		(0..<feedXml.size).each |i| {
			verifyEq(feedXml[i], testXml[i])			
		}

		verifyEq(feedXml, testXml)
	}
}
