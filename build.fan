using build

class Build : BuildPod {

	new make() {
		podName = "afAtom"
		summary = "A library for creating Atom (RSS) Feed Documents"
		version = Version("1.0.3")

		meta = [
			"proj.name"		: "Atom",
			"repo.internal"	: "true",
			"repo.tags"		: "web",
			"repo.public"	: "false"
		]

		depends = [
			"sys 1.0",
			"xml 1.0"
		]

		srcDirs = [`fan/`, `test/`]
		resDirs = [`doc/`, `test/`]
	}	
}
