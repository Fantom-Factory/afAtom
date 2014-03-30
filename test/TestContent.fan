
internal class TestContent : AtomTest {
	
	Void testFromText() {
		content := Content("wotever") {
			it.xmlBase = `/base`
			it.xmlLang = "xxx"
		}
		
		verifyContent(content, "<content xml:lang='xxx' xml:base='/base' type='text'>wotever</content>")
	}

	Void testFromXml1() {
		content := Content("<judge>dredd</judge>", MimeType("text/xml")) {
			it.xmlBase = `/base`
			it.xmlLang = "xxx"			
		}
		verifyContent(content, "<content xml:lang='xxx' xml:base='/base' type='text/xml'>
		                         <judge>dredd</judge>
		                        </content>")
	}

	Void testFromXml2() {
		content := Content("<judge>dredd</judge>", MimeType("text/groovy+xml")) {
			it.xmlBase = `/base`
			it.xmlLang = "xxx"			
		}
		verifyContent(content, "<content xml:lang='xxx' xml:base='/base' type='text/groovy+xml'>
		                         <judge>dredd</judge>
		                        </content>")
	}

	Void testFromStr() {
		content := Content("AT&T", MimeType("text/wotever")) {
			it.xmlBase = `/base`
			it.xmlLang = "xxx"			
		}
		verifyContent(content, "<content xml:lang='xxx' xml:base='/base' type='text/wotever'>AT&amp;T</content>")
	}

	Void testFromStrBase64() {
		content := Content("wotever", MimeType("wot/ever")) {
			it.xmlBase = `/base`
			it.xmlLang = "xxx"			
		}
		verifyContent(content, "<content xml:lang='xxx' xml:base='/base' type='wot/ever'>d290ZXZlcg==</content>")
	}

	Void testFromBinary() {
		content := Content("wotever".toBuf.in, MimeType("wot/ever")) {
			it.xmlBase = `/base`
			it.xmlLang = "xxx"			
		}
		verifyContent(content, "<content xml:lang='xxx' xml:base='/base' type='wot/ever'>d290ZXZlcg==</content>")
	}

	Void testFromSrc() {
		content := Content(`goto:hell`, MimeType("wot/ever")) {
			it.xmlBase = `/base`
			it.xmlLang = "xxx"			
		}
		verifyContent(content, "<content xml:lang='xxx' xml:base='/base' src='goto:hell' type='wot/ever'/>")
	}
	
}
