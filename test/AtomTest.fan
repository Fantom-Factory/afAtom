
internal class AtomTest : Test {

	Void verifyContent(Content content, Str xml) {
		verifyXml(content.toXml.writeToStr, xml)
	}

	Void verifyEntry(Entry entry, Uri xmlFile) {
		verifyXml(entry.toXml.writeToStr, xmlFile.toFile.readAllStr)
	}

	Void verifyFeed(Feed feed, Uri xmlFile) {
		verifyXml(feed.toXml.writeToStr, xmlFile.toFile.readAllStr)
	}

	Void verifyXml(Str atom, Str xml) {
		atomXml := atom.trim.splitLines		
		testXml := xml.trim.splitLines

		(0..<atomXml.size).each |i| {
			verifyEq(atomXml[i], testXml[i])			
		}

		verifyEq(testXml, atomXml)		
	}

	Void verifyErrTypeAndMsg(Type errType, Str errMsg, |Obj| func) {
		try {
			func(4)
		} catch (Err e) {
			if (!e.typeof.fits(errType)) 
				throw Err("Expected $errType got $e.typeof", e)
			verifyEq(errMsg, e.msg)	// this gives the Str comparator in eclipse
			return
		}
		throw Err("$errType not thrown")
	}
}
