/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.util;

	
 
import flash.events.EventDispatcher;
import org.aswing.event.AWEvent;

/**
 * Provides common routines for classes implemented
 * <code>Impulse</code> interface. 
 *
 * @author paling
 * @author Igor Sadovskiy
 */
class AbstractImpulser extends EventDispatcher  implements Impulser{
	private var delay:Int;
	private var initialDelay:Int;
	private var repeats:Int;
	private var isInitalFire:Bool;
	private var repeatCount:Int;
		
	/**
	 * Constructs <code>AbstractImpulser</code>.
     * @throws Error when init delay <= 0 or delay == null
	 */
	public function new(delay:Int, ?repeats:Int=0){
		this.delay = delay;
		this.initialDelay = 0;
		this.repeats = repeats;
		this.isInitalFire = true;
		repeatCount=repeats ;
		super();
	}
	
    /**
     * Adds an action listener to the <code>AbstractImpulser</code>
     * instance.
     *
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.AWEvent#ACT
     */	
	public function addActionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		 addEventListener(AWEvent.ACT, listener, false, priority, useWeakReference);
	}
	
	/**
	 * Removes a action listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.AWEvent#ACT
	 */
	public function removeActionListener(listener:Dynamic -> Void):Void{
		this.removeEventListener(AWEvent.ACT, listener);
	}
	
    /**
     * Sets the <code>AbstractImpulser</code>'s delay between 
     * fired events.
     *
     * @param delay the delay
     * @see #setInitialDelay()
     * @throws Error when set delay <= 0 or delay == null
     */	
	public function setDelay(delay:Int):Void{
		this.delay = delay;
	}
	
    /**
     * Returns the delay between firings of events.
     *
     * @see #setDelay()
     * @see #getInitialDelay()
     */	
	public function getDelay():Int{
		return delay;
	}
	
    /**
     * Sets the <code>AbstractImpulser</code>'s initial delay,
     * which by default is the same as the between-event delay.
     * This is used only for the first action event.
     * Subsequent events are spaced using the delay property.
     * 
     * @param initialDelay the delay 
     *                     between the invocation of the <code>start</code>
     *                     method and the first event
     *                     fired by this impulser
     *
     * @see #setDelay()
     * @throws Error when set initialDelay <= 0 or initialDelay == null
     */	
	public function setInitialDelay(initialDelay:Int):Void{

		this.initialDelay = initialDelay;
	}
	
    /**
     * Returns the <code>AbstractImpulser</code>'s initial delay.
     *
     * @see #setInitialDelay()
     * @see #setDelay()
     */	
	public function getInitialDelay():Int{
		if(initialDelay == 0){
			return delay;
		}else{
			return initialDelay;
		}
	}
	
	/**
     * If <code>flag</code> is <code>false</code>,
     * instructs the <code>AbstractImpulser</code> to send only once
     * action event to its listeners after a start.
     *
     * @param flag specify <code>false</code> to make the impulser
     *             stop after sending its first action event.
     *             Default value is true.
	 */
	public function setRepeats(flag:Int):Void{
		repeats = flag;
		repeatCount=repeats ;
	}
	
    /**
     * Returns <code>true</code> (the default)
     * if the <code>AbstractImpulser</code> will send
     * an action event to its listeners multiple times.
     *
     * @see #setRepeats()
     */	
	public function isRepeats():Bool{
		return repeats==0;
	}
	
	public function isRunning():Bool{
		return false;
	}
	
	public function stop():Void{}
	
	public function start():Void{}
	
	public function restart():Void { 
		}
}