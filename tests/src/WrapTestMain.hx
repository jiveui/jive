package ;

import jive.ScrollTest;

class WrapTestMain {
    static function main() {
        #if (debug && cpp)
        var startDebugger:Bool = false;
        var debuggerHost:String = "";
        var argStartDebugger:String = "-start_debugger";
        var pDebuggerHost:EReg = ~/-debugger_host=(.+)/;

        for (arg in Sys.args()) {
            if(arg == argStartDebugger){
                startDebugger = true;
            }
            else if(pDebuggerHost.match(arg)){
                debuggerHost = pDebuggerHost.matched(1);
            }
        }

        if(startDebugger){
            if(debuggerHost != "") {
                var args:Array<String> = debuggerHost.split(":");
                new debugger.HaxeRemote(true, args[0], Std.parseInt(args[1]));
            }
            else {
                new debugger.Local(true);
            }
        }
        #end

        // new TestMain();
        var test = new ScrollTest();
        test.test();
    }
}
