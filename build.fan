using build

class Build : BuildPod {

	new make() {
		podName = "afAtom"
		summary = "A library for creating Atom (RSS) Feed Documents"
		version = Version("1.0.1")

		meta = [
			"proj.name"		: "Atom",
			"internal"		: "true",
			"tags"			: "web",
			"repo.private"	: "true"
		]

		depends = [
			"sys 1.0",
			"xml 1.0"
		]

		srcDirs = [`test/`, `fan/`]
		resDirs = [`test/`]
	}	
}
