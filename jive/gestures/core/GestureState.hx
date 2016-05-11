package jive.gestures.core;

/**
 * ...
 * @author Josu Igoa
 */
class GestureState
{
	public static var POSSIBLE:GestureState;
	public static var RECOGNIZED:GestureState;
	public static var BEGAN:GestureState;
	public static var CHANGED:GestureState;
	public static var ENDED:GestureState;
	public static var CANCELLED:GestureState;
	public static var FAILED:GestureState;
	
	static var allStatesInitialized:Bool = false;
	
	var name:String;
	var eventType:String;
	var validTransitionStateMap:Map<GestureState, Bool>;
	public var isEndState:Bool;
	
	static public function initStates()
	{
		try {
			POSSIBLE = new GestureState("POSSIBLE");
			RECOGNIZED = new GestureState("RECOGNIZED", true);
			BEGAN = new GestureState("BEGAN");
			CHANGED = new GestureState("CHANGED");
			ENDED = new GestureState("ENDED", true);
			CANCELLED = new GestureState("CANCELLED", true);
			FAILED = new GestureState("FAILED", true);
			
			_initClass();
		} catch(e:Dynamic) {
			// ignore 
			trace(e);
		}
	}
	
	public function new(name:String, isEndState:Bool = false)
	{
		if (allStatesInitialized)
			throw "You cannot create gesture states. Use predefined constats like GestureState.RECOGNIZED";
		
		validTransitionStateMap = new Map<GestureState, Bool>();
		this.name = "GestureState." + name;
		this.eventType = "gesture." + name.toLowerCase();
		this.isEndState = isEndState;
	}
	
	static function _initClass()
	{
		POSSIBLE.setValidNextStates([RECOGNIZED, BEGAN, FAILED]);
		RECOGNIZED.setValidNextStates([POSSIBLE]);
		BEGAN.setValidNextStates([CHANGED, ENDED, CANCELLED]);
		CHANGED.setValidNextStates([CHANGED, ENDED, CANCELLED]);
		ENDED.setValidNextStates([POSSIBLE]);
		FAILED.setValidNextStates([POSSIBLE]);
		CANCELLED.setValidNextStates([POSSIBLE]);
		
		allStatesInitialized = true;
	}
	
	public function toString():String
	{
		return name;
	}
	
	
	function setValidNextStates(states:Array<GestureState>)
	{
		for (st in states)
			validTransitionStateMap[st] = true;
	}
	
	
	public function toEventType():String
	{
		return eventType;
	}
	
	
	public function canTransitionTo(state:GestureState):Bool
	{
		return validTransitionStateMap.exists(state);
	}
	
	//private var isEndState(default, null):Bool = false;
	//gestouch_internal function get isEndState():Boolean
	//{
		//return _isEndState;
	//}
}