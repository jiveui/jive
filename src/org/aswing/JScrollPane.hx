/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.events.MouseEvent;
import org.aswing.error.Error;
import org.aswing.geom.IntRectangle;
import org.aswing.event.ScrollPaneEvent;
import org.aswing.event.InteractiveEvent;
import org.aswing.plaf.basic.BasicScrollPaneUI;

/**
 * JScrollPane is a container with two scrollbar controllin the viewport's beeing viewed area.
 * <p>
 * If you want to change the unit or block increment of the scrollbars in a scrollpane, you shoud 
 * controll it with viewport instead of scrollbar directly, because the scrollbar's increment will 
 * be set to same to viewport's always. I mean use <code>JViewport.horizontalUnitIncrement</code> instead of
 * <code>JScrollBar.unitIncrement</code>
 * 
 * @see org.aswing.Viewportable
 * @see org.aswing.JViewport
 * @see org.aswing.JScrollBar
 * @author paling
 */
@:event("org.aswing.event.ScrollPaneEvent.SCROLLBAR_STATE_CHANGED", "Dispatched when one of the scrollpane's scrollbar state changed")
@:event("org.aswing.event.ScrollPaneEvent.VIEWPORT_CHANGED", "Dispatched when the viewport changed")
class JScrollPane extends Container {
		
    /**
     * scrollbar are displayed only when needed.
     */
    inline public static var SCROLLBAR_AS_NEEDED:Int= 0;
    /**
     * scrollbar are never displayed.
     */
    inline public static var SCROLLBAR_NEVER:Int= 1;
    /**
     * scrollbar are always displayed.
     */
    inline public static var SCROLLBAR_ALWAYS:Int= 2;

    /**
     * The viewport
     *
     * Most applications will find it more convenient to use
     * <code>#setView</code>
     * to add a viewport or a view to the scrollpane.
     *
     * @see #view
     * @see org.aswing.JList
     * @see org.aswing.JTextArea
     * @see org.aswing.JTable
     */
    public var viewport(get, set): Viewportable;
    private var _viewport: Viewportable;
    private function get_viewport(): Viewportable { return getViewport(); }
    private function set_viewport(v: Viewportable): Viewportable { setViewport(v); return v; }

    public var verticalScrollBar(get, set): JScrollBar;
    private var vScrollBar:JScrollBar;
    private function get_verticalScrollBar(): JScrollBar { return getVerticalScrollBar(); }
    private function set_verticalScrollBar(v: JScrollBar): JScrollBar { setVerticalScrollBar(v); return v; }

    public var horizontalScrollBar(get, set): JScrollBar;
    private var hScrollBar:JScrollBar;
    private function get_horizontalScrollBar(): JScrollBar { return getHorizontalScrollBar(); }
    private function set_horizontalScrollBar(v: JScrollBar): JScrollBar { setHorizontalScrollBar(v); return v; }

    /**
    * Values:
    *
    * - `#SCROLLBAR_AS_NEEDED`
    * - `#SCROLLBAR_NEVER`
    * - `#SCROLLBAR_ALWAYS`
    **/
    public var verticalScrollBarPolicy(get, set): Int;
    private var vsbPolicy:Int;
    private function get_verticalScrollBarPolicy(): Int { return Std.int(getVerticalScrollBarPolicy()); }
    private function set_verticalScrollBarPolicy(v: Int): Int { setVerticalScrollBarPolicy(v); return v; }

    /**
    * Values:
    *
    * - `#SCROLLBAR_AS_NEEDED`
    * - `#SCROLLBAR_NEVER`
    * - `#SCROLLBAR_ALWAYS`
    **/
    public var horizontalScrollBarPolicy(get, set): Int;
    private var hsbPolicy:Int;
    private function get_horizontalScrollBarPolicy(): Int { return Std.int(getHorizontalScrollBarPolicy()); }
    private function set_horizontalScrollBarPolicy(v: Int): Int { setHorizontalScrollBarPolicy(v); return v; }


	/**
	 * Create a JScrollPane, you can specified a Component to be view,
	 * then here will create a `JViewport` to manager the view's scroll,
	 * or a Viewportable to be the view, it mananger the scroll itself.
	 * If view is not instanceof either, no view will be viewed.
	 * 
	 * @param viewOrViewport the scroll content component or a Viewportable
	 * @param vsbPolicy `#SCROLLBAR_AS_NEEDED` or `#SCROLLBAR_NEVER` or `#SCROLLBAR_ALWAYS`, default `#SCROLLBAR_AS_NEEDED`
	 * @param hsbPolicy `#SCROLLBAR_AS_NEEDED` or `#SCROLLBAR_NEVER` or `#SCROLLBAR_ALWAYS`, default `#SCROLLBAR_AS_NEEDED`
	 * @throw TypeError when viewOrViewport is not component or viewportable.
	 * @see #SCROLLBAR_AS_NEEDED
	 * @see #SCROLLBAR_NEVER
	 * @see #SCROLLBAR_ALWAYS
	 * @see #setViewportView()
	 * @see #setViewport()
	 * @see org.aswing.Viewportable
	 * @see org.aswing.JViewport
	 * @see org.aswing.JList
	 * @see org.aswing.JTextArea
	 */
	public function new(viewOrViewport:Dynamic=null, vsbPolicy:Int=SCROLLBAR_AS_NEEDED, hsbPolicy:Int=SCROLLBAR_AS_NEEDED){
		super();
		setName("JScrollPane");
		this.vsbPolicy = vsbPolicy;
		this.hsbPolicy = hsbPolicy;
				
		setVerticalScrollBar(new JScrollBar(JScrollBar.VERTICAL));
		setHorizontalScrollBar(new JScrollBar(JScrollBar.HORIZONTAL));
		if(viewOrViewport != null){
			setView(viewOrViewport);
		}else{
			setViewport(new JViewport());
		}
		setLayout(new ScrollPaneLayout());
		updateUI();

        addEventListener(MouseEvent.MOUSE_WHEEL, function(e) {
            verticalScrollBar.value += verticalScrollBar.unitIncrement * e.delta;
        });
	}

    @:dox(hide)
    override public function updateUI():Void{
    	setUI(UIManager.getUI(this));
    }

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
    	return org.aswing.plaf.basic.BasicScrollPaneUI;
    }

    @:dox(hide)
	override public function getUIClassID():String{
		return "ScrollPaneUI";
	}	
	
	/**
	 * @throws ArgumentError when the layout is not ScrollPaneLayout instance.
	 */
    @:dox(hide)
	override public function setLayout(layout:LayoutManager):Void{
		if(Std.is(layout,ScrollPaneLayout)){
			super.setLayout(layout);
		}else{
			throw new  Error("Only can set ScrollPaneLayout to JScrollPane");
		}
	}
	
	/**
	 * @return true always here.
	 */
    @:dox(hide)
	override public function isValidateRoot():Bool{
		return true;
	}
	
	/**
	 * Sets the view to viewed and scrolled by this scrollpane.
	 * if this view is not a Viewportable implementation,
	 * then here will create a JViewport to manager the view's scroll,
	 * else the Viewportable will be the viewport.
	 * <br>
	 * If view is not instanceof either, no view will be set.
	 * <br>If you want to make a component viewed by your way, you have two way:
	 * <p>
	 * <ul>
	 * <li>1.Make your component a <code>Viewportable</code> implementation.
	 * <li>2.Make a your new <code>Viewportable</code> likes <code>JViewport</code>, recommend
	 * you extends the <code>JViewport</code>, then make your component to be the viewport's view like
	 * <code>JViewport</code> does.
	 * </ul>
	 * </p>
	 * @param viewOrViewport a component or a Viewportable object.
	 * @see Viewportable
	 * @throw TypeError when viewOrViewport is not component or viewportable.
	 */
	public function setView(viewOrViewport:Dynamic):Void {
		if (//Std.is(viewOrViewport, Viewportable)
		Std.is(viewOrViewport, JList)||
		Std.is(viewOrViewport, JTree)||
		Std.is(viewOrViewport, JTextArea)||
		Std.is(viewOrViewport, JTable) 
		) { 
			setViewport(AsWingUtils.as(viewOrViewport,Viewportable));
		}else if(Std.is(viewOrViewport,Component)){
			setViewportView(AsWingUtils.as(viewOrViewport,Component));
		}else  {
			throw new  Error("Only accept Component or Viewportable instance here!");
		}
	}
	
    /**
     * If currently viewport is a <code>JViewport</code> instance, 
     * set the view to it. If not, then creates a <code>JViewport</code> and then sets this view. 
     * Applications that don't provide the view directly to the <code>JScrollPane</code>
     * constructor should use this method to specify the scrollable child that's going
     * to be displayed in the scrollpane. For example:
     * <pre>
     * JScrollPane scrollpane = new JScrollPane();
     * scrollpane.setViewportView(myBigComponentToScroll);
     * </pre>
     * Applications should not add children directly to the scrollpane.
     *
     * @param view the component to add to the viewport
     * @see #setViewport()
     * @see org.aswing.JViewport#setView()
     */
	public function setViewportView(view:Component):Void{
		var jviewport:JViewport = AsWingUtils.as(getViewport() , JViewport);
		if(jviewport != null){
			jviewport.setView(view);
		}else{
			setViewport(new JViewport(view));
		}
	}
	
	/**
	 * Returns the view currently in the scrollpane's viewport if the viewport 
	 * is a JViewport instance, otherwise, null will be returned.
	 */
	public function getViewportView():Component{
		var jviewport:JViewport = AsWingUtils.as(getViewport() , JViewport);
		if(jviewport != null){
			return jviewport.getView();
		}else{
			return null;
		}
	}
	
    /**
     * Removes the old viewport (if there is one); and syncs the scrollbars and
     * headers with the new viewport.
     * <p>
     * Most applications will find it more convenient to use 
     * <code>setView</code>
     * to add a viewport or a view to the scrollpane.
     * 
     * @param viewport the new viewport to be used; if viewport is
     *		<code>null</code>, the old viewport is still removed
     *		and the new viewport is set to <code>null</code>
     * @see #getViewport()
     * @see #setViewportView()
     * @see org.aswing.JList
     * @see org.aswing.JTextArea
     * @see org.aswing.JTable
     */
    @:dox(hide)
	public function setViewport(vp:Viewportable):Void{
		if(_viewport != vp){
			if(_viewport != null){
				remove(_viewport.getViewportPane());
			}
			_viewport = vp;
			if(_viewport != null){
				insertImp(-1, _viewport.getViewportPane());
			}
			revalidate();
			dispatchEvent(new ScrollPaneEvent(ScrollPaneEvent.VIEWPORT_CHANGED, true, null, true));
		}
	}
	
	@:dox(hide)
    public function getViewport():Viewportable{
		return _viewport;
	}
	
	/**
	 * Returns the visible extent rectangle related the current scroll properties.
	 * @return the visible extent rectangle
	 */
	public function getVisibleRect():IntRectangle{
		return new IntRectangle(getHorizontalScrollBar().getValue(),
							 getVerticalScrollBar().getValue(),
							 getHorizontalScrollBar().getVisibleAmount(),
							 getVerticalScrollBar().getVisibleAmount());
	}
	
	/**
	 * Adds a scrollbar scrolled listener.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.ScrollPaneEvent#SCROLLBAR_STATE_CHANGED
	 */
	public function addAdjustmentListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void{
		addEventListener(ScrollPaneEvent.SCROLLBAR_STATE_CHANGED, listener, false, priority);
	}
	
	/**
	 * Removes a state listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.ScrollPaneEvent#SCROLLBAR_STATE_CHANGED
	 */
	public function removeAdjustmentListener(listener:Dynamic -> Void):Void{
		removeEventListener(ScrollPaneEvent.SCROLLBAR_STATE_CHANGED, listener);
	}
		
	/**
	 * Event handler for scroll bars
	 */
	private function __onBarScroll(e:InteractiveEvent):Void{
		dispatchEvent(new ScrollPaneEvent(ScrollPaneEvent.SCROLLBAR_STATE_CHANGED, 
		e.isProgrammatic(), AsWingUtils.as(e.target,JScrollBar), false));
	}
		
	/**
	 * Adds the scrollbar that controls the viewport's horizontal view position to the scrollpane. 
	 */
    @:dox(hide)
	public function setHorizontalScrollBar(horizontalScrollBar:JScrollBar):Void{
		if(hScrollBar != horizontalScrollBar){
			if(hScrollBar != null){
				hScrollBar.removeStateListener(__onBarScroll);
				remove(hScrollBar);
			}
			hScrollBar = horizontalScrollBar;
			if(hScrollBar != null){
				hScrollBar.setName("HorizontalScrollBar");
				insertImp(-1, hScrollBar);
				hScrollBar.addStateListener(__onBarScroll);
			}
			revalidate();
		}
	}

    @:dox(hide)
	public function getHorizontalScrollBar():JScrollBar{
		return hScrollBar;
	}

    @:dox(hide)
	public function setHorizontalScrollBarPolicy(policy:Float):Void{
		hsbPolicy = Std.int(policy);
	}

    @:dox(hide)
	public function getHorizontalScrollBarPolicy():Float{
		return hsbPolicy;
	} 
	
 	/**
	 * Adds the scrollbar that controls the viewport's vertical view position to the scrollpane. 
	 */
    @:dox(hide)
	public function setVerticalScrollBar(verticalScrollBar:JScrollBar):Void{
		if(vScrollBar != verticalScrollBar){
			if(vScrollBar != null){
				vScrollBar.removeStateListener(__onBarScroll);
				remove(vScrollBar);
			}
			vScrollBar = verticalScrollBar;
			if(vScrollBar != null){
				vScrollBar.setName("verticalScrollBar");
				insertImp(-1, vScrollBar);
				vScrollBar.addStateListener(__onBarScroll);
			}
			revalidate();
		}
	}

    @:dox(hide)
	public function getVerticalScrollBar():JScrollBar{
		return vScrollBar;
	}

    @:dox(hide)
	public function setVerticalScrollBarPolicy(policy:Float):Void{
		vsbPolicy = Std.int(policy);
	} 

	@:dox(hide)
    public function getVerticalScrollBarPolicy():Float{
		return vsbPolicy;
	}
	
	/**
	 * Sets the com to be the view.
	 */
    @:dox(hide)
	override public function append(com:Component, constraints:Dynamic=null):Void{
		setView(com);
	}
	
	/**
	 * Sets the com to be the view.
	 */
    @:dox(hide)
	override public function insert(i:Int, com:Component, constraints:Dynamic=null):Void{
		setView(com);
	}

    @:dox(hide)
	override private function getFocusTransmit():Component{
		return getViewport().getViewportPane();
	}	
}
