package ;

class GenHx {
	
	static function main() initHML();

	static macro function initHML() {
		jive.hml.JiveAdapter.register();
        #if site_target_desktop
		return macro hml.Hml.parse({path:"gen", autoCreate:true}, "declarations/desktop");
        #else
        return macro hml.Hml.parse({path:"gen", autoCreate:true}, "declarations/mobile");
        #end
	}
	
}