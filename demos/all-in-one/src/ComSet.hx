package;


import openfl.events.Event;
import componetset.Buttons;
import componetset.Scrolls;
import componetset.Containers;
import componetset.HeavyComs;
import componetset.Windows;
import componetset.Menus;
import componetset.Decorators;
import flash.display.Sprite;
import flash.Lib;
import org.aswing.JTabbedPane;
import org.aswing.JWindow;
import org.aswing.UIManager;
import org.aswing.SolidBackground;
import org.aswing.border.EmptyBorder;
import org.aswing.Insets;
	class ComSet extends Sprite{ 
	
	private var tabpane:JTabbedPane;
	public static var WINDOW:JWindow;
	
	public function new(){
		super();
 
		WINDOW = new JWindow(this);
		
		tabpane = new JTabbedPane(); 
	
		tabpane.append(new Windows());
		tabpane.append(new Buttons());
		tabpane.append(new Scrolls());
		tabpane.append(new Containers());
		tabpane.append(new HeavyComs());
		tabpane.append(new Menus());
		
		tabpane.append(new Decorators());

		WINDOW.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
		
		WINDOW.setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 4)));
		WINDOW.setContentPane(tabpane);
		WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		WINDOW.show();

        Lib.current.stage.addEventListener(Event.RESIZE, function(e) {
            WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        });
	}
	
}
