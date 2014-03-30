using xml

internal class TestFeed : AtomTest {
	
	Void testBriefFeed() {
		feed := Feed(`urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6`, Text("Example Feed"), DateTime.fromIso("2003-12-13T18:30:02Z"))
		feed.authors.add(Person("John Doe"))
		feed.links.add(Link(`http://example.org/`))
		feed.entries.add(
			Entry(`urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a`, Text("Atom-Powered Robots Run Amok"), DateTime.fromIso("2003-12-13T18:30:02Z")) {
				it.summary	= Text("Some text.")
				it.links.add(Link(`http://example.org/2003/12/13/atom03`))
			}
		)

		verifyFeed(feed, `test/feed-brief.xml`)		
	}
	
	Void testExtensiveFeed() {		
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
		entry.content	= Content("<p><i>[Update: The Atom draft is finished.]</i></p>", TextType.xhtml) {
			it.xmlBase = `http://diveintomark.org/`
			it.xmlLang = "en"
		}
		feed.entries.add(entry)

		verifyFeed(feed, `test/feed-extensive.xml`)
	}
}
