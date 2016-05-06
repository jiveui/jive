package;


import sys.FileSystem;
import haxe.io.Path;
import lime.tools.helpers.*;
import lime.tools.platforms.*;
import lime.project.*;
import sys.io.File;
import sys.io.Process;

class RunScript {

    private static var project: HXProject;
	
	public static function main () {
		
		var args = Sys.args ();
		var workingDirectory = args.pop ();

        if (args[0] == "build" || args[0] == "test") {

        }

		var args = [ "run", "lime" ].concat (args);
        LogHelper.verbose = true;

		try {
			
			Sys.setCwd (workingDirectory);

            var projectFile = findProjectFile (Sys.getCwd ());

            if (projectFile == "") {

                LogHelper.error ("You must have a \"project.xml\" file.");
                return;

            } else {
                LogHelper.info ("", LogHelper.accentColor + "Using project file: " + projectFile + LogHelper.resetColor);
            }

            project = new ProjectXMLParser (Path.withoutDirectory (projectFile), null, []);
            trace(project);

            var targetDirectory = project.app.path + "/jive";
            PathHelper.mkdir (targetDirectory);

            var context = generateContext ();

            var jive = new Haxelib ("jive");
            var jivePath = PathHelper.getHaxelib (jive);

            trace(jivePath);

            FileHelper.recursiveCopyTemplate([jivePath + "/templates"], "jive", targetDirectory, context);


		} catch (e:Dynamic) {
			LogHelper.error ("Cannot set current working directory to \"" + workingDirectory + "\"");
		}
		
//		Sys.exit (Sys.command ("haxelib", args.concat ([ "-openfl" ])));
		
	}

    private static function createBuildDirectory() {}
    private static function processHml() {}

    // From lime/tools/CommandLineTools.hx
    static private function findProjectFile (path:String):String {

        if (FileSystem.exists (PathHelper.combine (path, "project.hxp"))) {

            return PathHelper.combine (path, "project.hxp");

        } else if (FileSystem.exists (PathHelper.combine (path, "project.lime"))) {

            return PathHelper.combine (path, "project.lime");

        } else if (FileSystem.exists (PathHelper.combine (path, "project.nmml"))) {

            return PathHelper.combine (path, "project.nmml");

        } else if (FileSystem.exists (PathHelper.combine (path, "project.xml"))) {

            return PathHelper.combine (path, "project.xml");

        } else {

            var files = FileSystem.readDirectory (path);
            var matches = new Map <String, Array <String>> ();
            matches.set ("hxp", []);
            matches.set ("lime", []);
            matches.set ("nmml", []);
            matches.set ("xml", []);

            for (file in files) {

                var path = PathHelper.combine (path, file);

                if (FileSystem.exists (path) && !FileSystem.isDirectory (path)) {

                    var extension = Path.extension (file);

                    if ((extension == "lime" && file != "include.lime") || (extension == "nmml" && file != "include.nmml") || (extension == "xml" && file != "include.xml") || extension == "hxp") {

                        matches.get (extension).push (path);

                    }

                }

            }

            if (matches.get ("hxp").length > 0) {

                return matches.get ("hxp")[0];

            }

            if (matches.get ("lime").length > 0) {

                return matches.get ("lime")[0];

            }

            if (matches.get ("nmml").length > 0) {

                return matches.get ("nmml")[0];

            }

            if (matches.get ("xml").length > 0) {

                return matches.get ("xml")[0];

            }

        }

        return "";

    }

    static private function generateContext ():Dynamic {
        var context = project.templateContext;
        return context;
    }
}