package ;

class GenHx {
	
	static function main() initHML();

	@:access(hml.xml.XMLReader.XML_EXT)
	static macro function initHML() {
		jive.hml.JiveAdapter.register();
		hml.xml.XMLReader.XML_EXT = ~/(.hml$)/;
		return macro hml.Hml.parse({path:"::BUILD_DIR::/jive/gen", autoCreate:true}, "::JIVE_HML_SOURCE::");
	}
	
}