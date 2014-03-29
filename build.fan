using build

class Build : BuildPod {

	new make() {
		podName = "afAtom"
		summary = "(Internal) A library for creating Atom (RSS) feed documents"
		version = Version("0.0.1")

		meta = [
			"org.name"		: "Alien-Factory",
			"org.uri"		: "http://www.alienfactory.co.uk/",
			"proj.name"		: "Atom",
			"proj.uri"		: "http://www.fantomfactory.org/pods/afAtom",
			"vcs.uri"		: "https://bitbucket.org/AlienFactory/afatom",
			"license.name"	: "The MIT Licence",	
			"repo.private"	: "true"
		]


		depends = [
			"sys 1.0",
			"xml 1.0"
		]

		srcDirs = [`test/`, `fan/`]
		resDirs = [`doc/`, `test/`]

		docApi = true
		docSrc = true

		// exclude test code when building the pod
		srcDirs = srcDirs.exclude { it.toStr.startsWith("test/") }
		resDirs = resDirs.exclude { it.toStr.startsWith("test/") }
	}
}
