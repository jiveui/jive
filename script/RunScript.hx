package;


import haxe.crypto.Sha1;
import sys.FileSystem;
import haxe.io.Path;
import lime.tools.helpers.*;
import lime.tools.platforms.*;
import lime.project.*;
import sys.io.File;
import sys.io.Process;

class RunScript {

    private static var project: HXProject;

    static private function calcRecursiveHmlFilesHashForDirectory(dir: String): String {
        var temp = new StringBuf();
        var files = sys.FileSystem.readDirectory(dir);
        var r = ~/^.*\.hml$/;
        for (f in files) {
            var path = dir + "/" +  f;
            if (sys.FileSystem.isDirectory(path)) {
                if (f == "bin") continue;
                temp.add(calcRecursiveHmlFilesHashForDirectory(path));
            }
            if (r.match(f)) {
                temp.add(Sha1.encode(File.getContent(path)));
            }
        }
        return Sha1.encode(temp.toString());
    }

    static private function isHmlChanged(dir: String, hash: String) {

        var oldHash = null;
        var file = dir + "/cache_hash.txt";
        try {
            oldHash = File.getContent(file);
        } catch (e: Dynamic) {}

        if (oldHash == hash) {
            LogHelper.info("Jive: HML files are not modified since the last build.");
            return false;
        } else {
            if (!sys.FileSystem.exists(dir)) {
                sys.FileSystem.createDirectory(dir);
            }
            File.saveContent(file, hash);
            LogHelper.info("Jive: HML files are modified. Compiling...");
            return true;
        }
    }

	
	public static function main () {
		
		var args = Sys.args ();
		var workingDirectory = args.pop ();

        var shouldProcessHml =  args[0] == "build" || args[0] == "test";
		var args = [ "run", "lime" ].concat (args);
        LogHelper.verbose = true;


        try {
			Sys.setCwd (workingDirectory);
		} catch (e:Dynamic) {
			LogHelper.error ("Cannot set current working directory to \"" + workingDirectory + "\"");
		}

        if (shouldProcessHml) {
            var projectFile = findProjectFile (Sys.getCwd ());

            if (projectFile == "") {

                LogHelper.error ("You must have a \"project.xml\" file.");
                return;

            } else {
                LogHelper.info ("", LogHelper.accentColor + "Using project file: " + projectFile + LogHelper.resetColor);
            }

            project = new ProjectXMLParser (Path.withoutDirectory (projectFile), null, []);
            project.command = "build";
            project.debug = false;
            project.target = PlatformHelper.hostPlatform;
            project.targetFlags = new Map <String, String> ();
            project.targetFlags.set ("cpp", "");

            var targetDirectory = project.app.path + "/jive";
            PathHelper.mkdir (targetDirectory);

            var context = generateContext ();

            var jive = new Haxelib ("jive");
            var jivePath = PathHelper.getHaxelib (jive);

            FileHelper.recursiveCopyTemplate([jivePath + "/templates"], "jive", targetDirectory, context);

            if (isHmlChanged(targetDirectory, calcRecursiveHmlFilesHashForDirectory(project.sources[0]))) {
                ProcessHelper.runCommand ("", "haxe", [ targetDirectory + "/gen.hxml" ]);
            }

            args = args.concat(["--source=" + targetDirectory+"/gen"]);
        }

		Sys.exit (Sys.command ("haxelib", args.concat ([ "-openfl" ])));
		
	}

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
        context.JIVE_HML_SOURCE = project.sources[0];
        return context;
    }
}