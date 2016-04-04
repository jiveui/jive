/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

import org.aswing.KeyType;

/**
 * KeyMap is a key definition -> action map.
 * @see org.aswing.KeyDefinition
 * @author paling
 */
class KeyMap {
	
	private var map:haxe.ds.StringMap<KeyAction>;
	
	/**
	 * Creates a key map.
	 */
	public function new(){
		map = new haxe.ds.StringMap<KeyAction>();
	}
	
	/**
	 * Registers a key definition -> action pair to the map. If same key definition is already 
	 * in the map, it will be replaced with the new one.
	 * @param key the key definition.
	 * @param action the aciton function
	 */
	public function registerKeyAction(key:KeyType, action:Dynamic):Void{
		map.set(getCodec(key), new KeyAction(key, action));
	}
	
	/**
	 * Unregisters a key and its action value.
	 * @param key the key and its value to be unrigesterd.
	 */
	public function unregisterKeyAction(key:KeyType):Void{
		map.remove(getCodec(key));
	}
	
	/**
	 * Returns the action from the key defintion.
	 * @param key the key definition
	 * @return the action.
	 * @see #getCodec()
	 */
	public function getKeyAction(key:KeyType):Dynamic{
		return getKeyActionWithCodec(getCodec(key));
	}
	
	private function getKeyActionWithCodec(codec:String):Dynamic{
		var ka:KeyAction = map.get(codec);
		if(ka != null){
			return ka.action;
		}
		return null;
	}
	
	/**
	 * Fires a key action with key sequence.
	 * @return whether or not a key action fired with this key sequence.
	 */
	public function fireKeyAction(keySequence:Array<Dynamic>):Bool{
		var codec:String= getCodecWithKeySequence(keySequence);
		var action:Dynamic= getKeyActionWithCodec(codec);
		if(action != null){
			action();
			return true;
		}
		return false;
	}
	
	/**
	 * Returns whether the key definition is already registered.
	 * @param key the key definition
	 */
	public function containsKey(key:KeyType):Bool{
		return map.exists(getCodec(key));
	}
	
	/**
	 * Returns the codec of a key definition, same codec means same key definitions.
	 * @param key the key definition
	 * @return the codec of specified key definition
	 */
	public static function getCodec(key:KeyType):String{
		return getCodecWithKeySequence(key.getCodeSequence());
	}
	
	/**
	 * Returns the codec of a key sequence.
	 * @param keySequence the key sequence
	 * @return the codec of specified key sequence
	 */
	public static function getCodecWithKeySequence(keySequence:Array<Dynamic>):String{
		return keySequence.join("|");
	}
}




class KeyAction{
	public var key:KeyType;
	public var action:Dynamic;
	
	public function new(key:KeyType, action:Dynamic){
		this.key = key;
		this.action = action;
	}
}