package;
import openfl.events.Event;
import flash.display.Sprite;
import flash.Lib; 
import org.aswing.AsWingManager;

class Main extends Sprite {
	 
   public function new() {
       super();
       AsWingManager.initAsStandard( Lib.current);
       Lib.current.addChild(new ComSet());
   }
}
