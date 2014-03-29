
internal class AtomTest : Test {

	Void verifyFeed(Feed feed, Uri xmlFile) {
		feedXml := feed.toXml.writeToStr.trim.splitLines		
		testXml := xmlFile.toFile.readAllStr.trim.splitLines

		Env.cur.err.printLine(feed.toXml.writeToStr)

		(0..<feedXml.size).each |i| {
			verifyEq(feedXml[i], testXml[i])			
		}

		verifyEq(feedXml, testXml)		
	}

}
