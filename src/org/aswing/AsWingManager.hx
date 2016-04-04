/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import flash.display.Stage;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
import org.aswing.event.AWEvent;
import org.aswing.util.Timer;

import org.aswing.error.AsWingManagerNotInited;
import org.aswing.geom.IntDimension;

/**
 * The main manager for AsWing framework.
 * <p>
 * You may need to call <code>setRoot()</code> to set a default root container for 
 * AsWing Popups.
 * </p>
 * @see JPopup
 * @author paling
 */
class AsWingManager{
	
	private static var stage:Stage=null;
    private static var ROOT:DisplayObjectContainer;
    private static var INITIAL_STAGE_WIDTH:Int;
    private static var INITIAL_STAGE_HEIGHT:Int;
    private static var timer:Timer;
    private static var nextFrameCalls:Array<Dynamic>= new Array<Dynamic>();
    private static var preventNullFocus:Bool= true;
    
    /**
     * Sets the root container for AsWing components based on.
     * <p>
     * You'd better call this method before application start, before flashplayer 
     * stage resized.
     * </p>
     * Default is <code>AsWingManager.getStage()</code>.
     * @param root the root container for AsWing popups.
     */
    public static function setRoot(root:DisplayObjectContainer):Void{
		ROOT = root;
        if(root != null && stage == null && root.stage != null){
        	initStage(root.stage);
        }
    }
    
    /**
     * Init AsWing as a standard setting. This method is very important for your App.
     * <p>
     * <ul>
     * <li>If your app is a general Web app or AIR app just have one window(i mean just one stage), you can easy 
     * to pass your root here, and then later you can easy to use <code>AsWingManager.getStage()</code>.
     * </li>
     * <li>If your app is a multi-stage app, (for example AIR app with more than one NativeWindow), you'd better to pass null for this, 
     * 	then the manager will not reference to your stage to make it is GC able when the NativeWindow is close.
     * </li>
     * </ul>
     * </p>
     * @param root the default root container for aswing popups, or null to make no default root.
     * @param _preventNullFocus set true to prevent focus transfer to null, false, not manage to do this
     * @param workWithFlex set this to true if your application ui has both AsWing components and Flex components.
     * @see #setRoot()
     * @see #setPreventNullFocus()
     * @see RepaintManager#setAlwaysUseTimer()
     */
    public static function initAsStandard(
    				root:DisplayObjectContainer, 
    				_preventNullFocus:Bool=true, 
    				workWithFlex:Bool = false):Void {
						
		 setRoot(root); 			
		
		if(stage!=null)	{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
		}
		preventNullFocus = _preventNullFocus;
		RepaintManager.getInstance().setAlwaysUseTimer(workWithFlex);
		AsWingUtils.initAsStandard();
    }
    
    /**
     * Sets whether or not prevent focus transfer to null when user click a blank(not focusable object).
     * The default value is true, it is suit for normal applications, if you are develop a app 
     * that are complex and may have other interactive object is not aswing components, you may need to 
     * set this value to false.
     * @param prevent set true to prevent focus transfer to null, false, not manage to do this
     */
    public static function setPreventNullFocus(prevent:Bool):Void{
    	preventNullFocus = prevent;
    }
    
    /**
     * Returns the preventNullFocus property.
     * @return true means will prevent focus transfer to null, false means do not manage this.
     * @see #setPreventNullFocus()
     */
    public static function isPreventNullFocus():Bool{
    	return preventNullFocus;
    }
    
    /**
     * Sets the intial stage size, this method generally do not need to use.
     * But some times, you know the manager is not initied at right time, i means 
     * some times the manager is inited after the stage is resized, so, you maybe need 
     * to call this method to correct the size.
     * @param width the width of stage when application start.
     * @param width the height of stage when application start.
     */
    public static function setInitialStageSize(width:Int, height:Int):Void{
    	INITIAL_STAGE_WIDTH = width;
    	INITIAL_STAGE_HEIGHT = height;
    }
    
    /**
     * Returns the stage initial size.
     * @return the size. 
     */
    public static function getInitialStageSize():IntDimension{
    	if(ROOT == null){
    		throw new AsWingManagerNotInited();
    	}
    	return new IntDimension(INITIAL_STAGE_WIDTH, INITIAL_STAGE_HEIGHT);
    }
    
    /**
     * Returns the root container which components base on.
     * If you have not set a specified root, the first stage will be the root to be returned.
     * <p>
     * Take care to use this method if you are working on a multiple native windows AIR project, 
     * because there maybe more than one stage.
     * </p>
	 * @param checkError whethor or not check root is inited set.
     * @return the root container, or null--not root set and AsWingManager not stage inited.
	 * @throws AsWingManagerNotInited if checkError and both root and stage is null.
     * @see #setRoot()
     * @see #getStage()
     */ 
    public static function getRoot(checkError:Bool=true):DisplayObjectContainer{
      
        return ROOT;
    }	
	
	/**
	 * Init the stage for AsWing, this method should be better called when flashplayer start.
	 * This method will be automatically called when a component is added to stage.
	 * @param theStage the stage
	 */
	public static function initStage(theStage:Stage):Void{
		if(stage == null){
			stage = theStage;
	        INITIAL_STAGE_WIDTH = Std.int(stage.stageWidth);
	        INITIAL_STAGE_HEIGHT = Std.int(stage.stageHeight);
		}
	}
	
	/**
	 * Returns whether or not stage is set to the manager.
	 * @return whether or not stage is set to the manager.
	 */
	public static function isStageInited():Bool{
		return stage != null;
	}
	
	/**
	 * Returns the stage inited by <code>initAsStandard()</code> or <code>setRoot</code>.
	 * <p>
     * Take care to use this method if you are working on a multiple native windows AIR project, 
     * because there maybe more than one stage.
     * </p>
	 * @param checkError whethor or not check is stage is inited set.
	 * @return the stage.
	 * @throws AsWingManagerNotInited if checkError and stage is null.
	 * @see #initAsStandard()
	 * @see #setRoot()
	 */
	public static function getStage(checkError:Bool=true):Stage{
		if(checkError && stage==null){
			throw new AsWingManagerNotInited();
		}
		return stage;
	}
	
	/**
	 * Force the screen to be updated after a time.
	 * @param delay the time
	 */
	public static function updateAfterMilliseconds(delay:Int= 20):Void{
		if(timer == null){
			timer = new Timer(delay, 0);
			timer.addEventListener(AWEvent.ACT, __update);
		}
		if(timer.isRunning()!=true){
			timer.restart();
		}
	}
	
	private static var frameTrigger:Sprite;
	/**
	 * Adds a function to the queue to be invoked at next enter frame time
	 * @param func the function to be invoked at next frame
	 */
	public static function callNextFrame(func:Dynamic -> Void):Void{
		if(frameTrigger == null){
			frameTrigger = new Sprite();
			frameTrigger.addEventListener(Event.ENTER_FRAME, __enterFrame);
		}
		nextFrameCalls.push(func);
	}
	
	public static function callLater(func:Void -> Void, time:Int=40):Void{
		var timer:Timer = new Timer(time, 0);
		timer.addEventListener(AWEvent.ACT, function(e:AWEvent):Void{
			func();
		});
		timer.start();
	}
	
	private static function __update(e:AWEvent):Void{
		//e.updateAfterEvent();
	}
	
	private static function __enterFrame(e:Event):Void{
		var calls:Array<Dynamic>= nextFrameCalls;
		nextFrameCalls = new Array<Dynamic>();
		for(i in 0...calls.length){
			var func:Void->Void= calls[i];
			func();
		}
	}
}