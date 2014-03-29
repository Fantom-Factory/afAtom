using xml

class TestFeed : AtomTest {
	
	Void test() {
		
		feed := Feed(`tag:example.org,2003:3`, "dive into mark", DateTime.fromIso("2005-07-31T12:29:29Z"))
		
		feedXml := feed.toXml.writeToStr		
		testXml := `test/atom-feed.xml`.toFile.readAllStr
		
		Env.cur.err.printLine(feedXml)
		
		verifyEq(feedXml, testXml)
	}
}
