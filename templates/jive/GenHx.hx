package ;

class GenHx {
	
	static function main() initHML();

	static macro function initHML() {
		jive.hml.JiveAdapter.register();
		return macro hml.Hml.parse({path:"::BUILD_DIR::/jive/gen", autoCreate:true}, "::JIVE_HML_SOURCE::");
	}
	
}