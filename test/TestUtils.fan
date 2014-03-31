
internal class TestUtils : AtomTest {
	
	Void testInvalidXml1() {
		verifyErrTypeAndMsg(ParseErr#, "Could not parse XML: <judge>dredd<judge>") {
			Content("<judge>dredd<judge>", MimeType("text/xml")).toXml
		}
	}

	Void testInvalidXml2() {
		verifyErrTypeAndMsg(ParseErr#, "Could not parse XML: <judge whoops>dredd</judge>") {
			Content("<judge whoops>dredd</judge>", MimeType("text/xml")).toXml
		}
	}

	Void testInvalidXml3() {
		verifyErrTypeAndMsg(ParseErr#, "XML is only allowed ONE root element") {
			Content("<span>judge</span><span>dredd</span>", MimeType("text/xml")).toXml
		}
	}
	
}
