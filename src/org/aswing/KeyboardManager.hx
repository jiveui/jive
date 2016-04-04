/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import flash.display.DisplayObjectContainer;
import org.aswing.error.Error;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.KeyboardEvent;
import org.aswing.AWKeyboard;

import org.aswing.util.ArrayList;
	/**
 * Dispatched when key is down.
 * @eventType flash.events.KeyboardEvent.KEY_DOWN
 */
// [Event(name="keyDown", type="flash.events.KeyboardEvent")]

/**
 * Dispatched when key is up.
 * @eventType flash.events.KeyboardEvent.KEY_UP
 */
// [Event(name="keyUp", type="flash.events.KeyboardEvent")]

/**
 * KeyboardController controlls the key map for the action firing.
 * <p>
 * Thanks Romain for his Fever{@link http://fever.riaforge.org} accelerator framworks implementation, 
 * this is a simpler implementation study from his.
 * 
 * @see org.aswing.KeyMap
 * @see org.aswing.KeyType
 * @author paling
 */
class KeyboardManager extends EventDispatcher {
	
	private static var defaultMnemonicModifier:Array<Dynamic>= [AWKeyboard.CONTROL, AWKeyboard.SHIFT];
	
	private var keySequence:ArrayList;
	private var keymap:KeyMap;
	private var inited:Bool;
	private var mnemonicModifier:Array<Dynamic>;
	private var keyJustActed:Bool;
	private var enabled:Bool;
	
	
	/**
	 * Singleton class, 
	 * Don't create instance directly, in stead you should call <code>getInstance()</code>.
	 */
	public function new(){
		enabled = true;
		inited = false;
		keyJustActed = false;
		keySequence = new ArrayList();
		keymap = new KeyMap();
		mnemonicModifier = null;
		super();
	}
	
	/**
	 * Init the keyboad manager, it will only start works when it is inited.
	 * @param root the key trigger root of this keyboard manager.
	 * @throws Error if it is already inited.
	 */
	public function init(root:DisplayObjectContainer):Void{
		if(inited!=true){
			inited = true;
			root.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown, false, 0, true);
			root.addEventListener(KeyboardEvent.KEY_UP, __onKeyUp, false, 0, true);
			root.addEventListener(Event.DEACTIVATE, __deactived, false, 0, true);
			
			//root.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDownCap, true);
			//root.addEventListener(KeyboardEvent.KEY_UP, __onKeyUpCap, true);
		}else{
			throw new Error("This KeyboardManager was already inited!");
		 
		}
	}
		
	/**
	 * Registers a key action to the default key map of this controller.
	 * @param key the key type
	 * @param action the action
	 * @see KeyMap#registerKeyAction()
	 */
	public function registerKeyAction(key:KeyType, action:Dynamic -> Void):Void{
		keymap.registerKeyAction(key, action);
	}
	
	/**
	 * Unregisters a key action to the default key map of this controller.
	 * @param key the key type
	 * @see KeyMap#unregisterKeyAction()
	 */
	public function unregisterKeyAction(key:KeyType):Void{
		keymap.unregisterKeyAction(key);
	}
	
	public function getKeyMap():KeyMap{
		return keymap;
	}
	
	/**
	 * Returns whether or not the key is down.
	 * @param the key code
	 * @return true if the specified key is down, false if not.
	 */
	public function isKeyDown(keyCode:Int):Bool{
		return keySequence.contains(keyCode);
	}
	
	/**
	 * Sets the mnemonic modifier key codes, the default is [Ctrl, Shift], however 
	 * for normal UI frameworks, it is [Alt], but because the flashplayer or explorer will 
	 * eat [Alt] for thier own mnemonic modifier, so we set our default to [Ctrl, Shift].
	 * <p>
	 * Sets null to make it allways keep same to <code>getDefaultMnemonicModifier</code>
	 * </p>
	 * @param keyCodes the array of key codes to be the mnemoic modifier.
	 */
	public function setMnemonicModifier(keyCodes:Array<Dynamic>):Void{
		if(keyCodes == null){
			keyCodes = null;
		}else{
			mnemonicModifier = keyCodes.copy();
		}
	}
	
	public static function getDefaultMnemonicModifier():Array<Dynamic>{
		return defaultMnemonicModifier.copy();
	}
	
	public static function setDefaultMnemonicModifier(keyCodes:Array<Dynamic>):Void{
		defaultMnemonicModifier = keyCodes.copy();
	}
	
	public function setEnabled(b:Bool):Void{
		enabled = b;
		if(b!=true){
			keySequence.clear();
		}
	}
	
	public function isEnabled():Bool{
		return enabled;
	}
	
	public function getMnemonicModifier():Array<Dynamic>{
		if(mnemonicModifier == null){
			return getDefaultMnemonicModifier();
		}else{
			return mnemonicModifier.copy();
		}
	}
	
	/**
	 * Returns whether or not the mnemonic modifier keys is down.
	 * @return whether or not the mnemonic modifier keys is down.
	 */
	public function isMnemonicModifierDown():Bool{
		var mm:Array<Dynamic>= getMnemonicModifier();
		for(i in 0...mm.length){
			if(!isKeyDown(mm[i])){
				return false;
			}
		}
		return mm.length > 0;
	}
	
	/**
	 * Returns whether or not just a key action acted when the last key down.
	 * @return true if there's key actions acted at last key down, false not.
	 */
	public function isKeyJustActed():Bool{
		return keyJustActed;
	}
		
	private function __onKeyDown(e:KeyboardEvent) : Void{
		if(enabled!=true){
			return;
		}
		dispatchEvent(e);
		var code:Int= e.keyCode;
		if(!keySequence.contains(code)){
			keySequence.append(code);
		}
		keyJustActed = false;
		if(keymap.fireKeyAction(keySequence.toArray())){
			keyJustActed = true;
		}
	}

	private function __onKeyUp(e:KeyboardEvent) : Void{
		if(enabled!=true){
			return;
		}
		dispatchEvent(e);
		var code:Int= e.keyCode;
		keySequence.remove(code);
		//avoid IME bug that can't trigger keyup event when active IME and key up
		if(e.ctrlKey!=true){
			keySequence.remove(AWKeyboard.CONTROL);
		}
		if(e.shiftKey!=true){
			keySequence.remove(AWKeyboard.SHIFT);
		}
	}
	
	private function __deactived(e:Event):Void{
		keySequence.clear();
	}
}