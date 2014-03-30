using xml

internal const mixin Utils {
	
	static XElem parseXml(Str xml) {
		try {
			parser := XParser(xml.in)
			parser.next
			return parser.parseElem

		} catch (XErr xErr) {
			line := (xErr.line > 0) ? ": " + xml.splitLines[xErr.line-1] : ""
			throw ParseErr("Could not parse XML" + line, xErr)
		}
	}

}
