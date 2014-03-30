
internal class TestEntry : AtomTest {
	
	Void testSourceFeed() {
		feed := Feed(`urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6`, Text("Example Feed"), DateTime.fromIso("2003-12-13T18:30:02Z"))
		feed.authors.add(Person("John Doe"))
		feed.entries.add(
			Entry(`urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a`, Text("Atom-Powered Robots Run Amok"), DateTime.fromIso("2003-12-13T18:30:02Z"))
		)

		entry := Entry(`123456`, Text("Fantom"), DateTime.fromIso("2010-04-20T00:00:00Z")) {
			it.source = feed
		}

		verifyEntry(entry, `test/entry-w-source.xml`)		
	}
}
