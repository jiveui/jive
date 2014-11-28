/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.util;

import haxe.Timer;	 
import org.aswing.error.Error;
import org.aswing.event.AWEvent;
/**
 * Fires one or more action events after a specified delay.  
 * For example, an animation object can use a <code>Timer</code>
 * as the trigger for drawing its frames.
 *
 * <p>
 * Setting up a timer
 * involves creating a <code>Timer</code> object,
 * registering one or more action listeners on it,
 * and starting the timer using
 * the <code>start</code> method.
 * For example, 
 * the following code creates and starts a timer
 * that fires an action event once per second
 * (as specified by the first argument to the <code>Timer</code> constructor).
 * The second argument to the <code>Timer</code> constructor
 * specifies a listener to receive the timer's action events.
 * </p>
 * <pre>
 *  var delay:Number = 1000; //milliseconds
 *  var listener:Object = new Object();
 *  listener.taskPerformer = function(e:Event) {
 *          <em>//...Perform a task...</em>
 *      }
 *  var timer:Timer = new Timer(delay);
 *  timer.addActionListener(listener.taskPerformer);
 *  timer.start();
 * </pre>
 *
 * <p>
 * @author paling
 */
class Timer extends AbstractImpulser  implements Impulser{
 
	 
	
	public var currentCount:Int; 
	public var running:Bool;
	 
    private var timer:haxe.Timer;
	
	
	public function new(delay:Int, repeatCount:Int = 0)
	{
		if (Math.isNaN (delay) || delay < 0)
		{
			throw new Error ("The delay specified is negative or not a finite number");
		}
		
		super (delay,repeatCount);
		 
		currentCount = 0;
	}
	
	
	public function reset()
	{
		if (running)
		{
			stop ();
		}
		currentCount = 0;
	}
	
	
	override public function start()
	{
		if (!running)
		{
			running = true;
			timer = new haxe.Timer (delay);
			timer.run = fireActionPerformed;
		}
	}
	
	override public function restart():Void { 
	
		
		reset();
		start();
	}
	override public function stop()
	{
		running = false;
		
		if (timer != null)
		{
			timer.stop();
			timer = null;
		}
	}
	
	
	
	override public function setDelay(delay:Int):Void{
		this.delay = delay;
		if (running)
		{
			stop();
			start();
		}
		
	}
	
    /**
     * Returns the delay between firings of events.
     *
     * @see #setDelay()
     * @see #getInitialDelay()
     */	
	override public function getDelay():Int{
		return delay;
	}
	
	 
	
	
	
	private function fireActionPerformed ():Void
	{
		currentCount ++; 
		if (repeatCount > 0 && currentCount >= repeatCount)
		{
			stop ();
			dispatchEvent(new AWEvent(AWEvent.ACT));
			dispatchEvent(new AWEvent(AWEvent.ACT_COMPLETE));
		}
		else
		{
			dispatchEvent(new AWEvent(AWEvent.ACT));
		}
	}
	
} 
