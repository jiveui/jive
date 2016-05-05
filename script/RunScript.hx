package;


import lime.tools.helpers.LogHelper;
import lime.tools.helpers.PathHelper;
import lime.project.Haxelib;


class RunScript {
	
	
	public static function main () {
		
		var args = Sys.args ();
		var workingDirectory = args.pop ();

        if (args[0] == "build" || args[1] == "test") {

        }

		var args = [ "run", "lime" ].concat (args);
		
		try {
			
			Sys.setCwd (workingDirectory);
			
		} catch (e:Dynamic) {
			
			LogHelper.error ("Cannot set current working directory to \"" + workingDirectory + "\"");
			
		}
		
		Sys.exit (Sys.command ("haxelib", args.concat ([ "-openfl" ])));
		
	}

    private static function createBuildDirectory() {}
    private static function processHml() {}
	
	
}