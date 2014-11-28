/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.util;

	
/**
 * Declares API to fire one or more action events after a 
 * specified delay.  
 * 
 * @author paling
 * @author Igor Sadovskiy
 */	
interface Impulser{
	/**
     * Adds an action listener to the <code>Impulser</code>
     * instance.
     *
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.AWEvent#ACT
	 */
	function addActionListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void;
	
	/**
	 * Removes a action listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.AWEvent#ACT
	 */
	function removeActionListener(listener:Dynamic -> Void):Void;	
	
    /**
     * Sets the <code>Impulser</code>'s delay between fired events.
     *
     * @param delay the delay
     * @see #setInitialDelay()
     */	
	 function setDelay(delay:Int):Void;
	
    /**
     * Returns the delay between firings of events.
     *
     * @see #setDelay()
     * @see #getInitialDelay()
     */	
	 function getDelay():Int;
	
    /**
     * Sets the <code>Impulser</code>'s initial delay,
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
     */	
	 function setInitialDelay(initialDelay:Int):Void;
	
    /**
     * Returns the <code>Impulser</code>'s initial delay.
     *
     * @see #setInitialDelay()
     * @see #setDelay()
     */	
	 function getInitialDelay():Int;
	
	/**
     * If <code>flag</code> is <code>false</code>,
     * instructs the <code>Impulser</code> to send only once
     * action event to its listeners after a start.
     *
     * @param flag specify <code>false</code> to make the impulser
     *             stop after sending its first action event.
	 */
	 function setRepeats(flag:Int):Void;
	
    /**
     * Returns <code>true</code> (the default)
     * if the <code>Impulser</code> will send
     * an action event to its listeners multiple times.
     *
     * @see #setRepeats()
     */	
	 function isRepeats():Bool;
	
    /**
     * Starts the <code>Impulser</code>,
     * causing it to start sending action events
     * to its listeners.
     *
     * @see #stop()
     */
     function start():Void;
    
    /**
     * Returns <code>true</code> if the <code>Impulser</code> is running.
     *
     * @see #start()
     */
     function isRunning():Bool;
    
    /**
     * Stops the <code>Impulser</code>,
     * causing it to stop sending action events
     * to its listeners.
     *
     * @see #start()
     */
     function stop():Void;
    
    /**
     * Restarts the <code>Impulser</code>,
     * canceling any pending firings and causing
     * it to fire with its initial delay.
     */
     function restart():Void;
}