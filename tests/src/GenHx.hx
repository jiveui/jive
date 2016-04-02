package ;

class GenHx {
	
	static function main() initHML();

	static macro function initHML() {
		jive.hml.JiveAdapter.register();
		return macro hml.Hml.parse({path:"tests/bin/gen", autoCreate:true}, "tests/src");
	}
	
}