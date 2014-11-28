/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.resizer;


import org.aswing.error.Error;
import org.aswing.Component;

import org.aswing.resizer.DefaultResizer;
import org.aswing.resizer.Resizer; 

/**
 * ResizerController make manage resizer feature easily.
 * 
 * <pre>
 *  var button : JButton = new JButton("click");
 *  button.setSize( 100,25 );
 * 	button.setLocation( 100, 100 );
 * 	
 * 	var label1 : JLabel = new JLabel("avoid resizing");
 * 	label1.setSize(100, 25);
 * 	label1.setLocation( 200, 50 );
 * 	
 *  var label2 : JLabel = new JLabel("ok for resizing");
 * 	label2.setSize(100, 25);
 * 	label2.setLocation( 50, 50 );
 * 	label2.setOpaque( true );
 * 
 * 	try
 * 	{
 * 		// Direct affectation
 * 		var resizer : ResizerController = ResizerController.init( button );
 * 		
 * 		// Simple call to #init method
 * 		ResizerController.init( label1 );
 * 		ResizerController.init( label2 );
 * 	}
 * 	catch( e : Error )
 * 	{
 * 		// log error message
 * 	}
 * 	
 * 	//We can retreive ResizerController for a specific component like :
 * 	var labelResizer : ResizerController = ResizerController.getController( label1 );
 * 	labelResizer.setResizable( false );
 * 	
 * 	resizer.setResizeDirectly( true );
 * 	
 * 	// content must have a layout set to EmptyLayout to allow correct resizing
 * 	content.append( button );
 * 	content.append( label1 );
 * 	content.append( label2 );
 * </pre>
 * <p>
 * Many thanks Romain Ecarnot, this class is based on his ResizerController, and all resizer implement 
 * are inspired by him.
 * </p>
 * @author Romain Ecarnot
 * @author paling
 */
class ResizerController{
	//-------------------------------------------------------------------------
	// Private properties
	//-------------------------------------------------------------------------
	
	private static var defaultResizerClass:Class<Dynamic>;
	
	private var _component : Component;
	
	private var _resizer : Resizer;
	private var _resizable : Bool;
	private var _resizableDirectly : Bool;
	
	
	//-------------------------------------------------------------------------
	// Public API
	//-------------------------------------------------------------------------
	
	/**
	 * Sets the default resizer class.
	 * @param cl the default resizer class.
	 */
	public static function setDefaultResizerClass(cl:Class<Dynamic>):Void{
		defaultResizerClass = cl;
	}
	
	/**
	 * Returns the default resizer class.
	 */
	public static function getDefaultResizerClass():Class<Dynamic>{
		return defaultResizerClass;
	}
	
	/**
	 * Create resizing behaviour to passed-in component.
	 * @param comp the component which need to be resizable
	 * @param resizer (optional)the resizer, default there will be a default one instance created.
	 */
	public static function create( comp : Component , resizer:Resizer=null) : ResizerController
	{
		return new ResizerController( comp , resizer);
	}
		
	/**
	 * Returns reference to the real used component.
	 */
	public function getComponent() : Component
	{
		return _component;
	}
	
	/**
	 * Returns whether this component is resizable by the user.
	 * 
	 * <p>By default, all components are initially resizable. 
	 * 
	 * @see #setResizable()
	 */
	public function isResizable() : Bool{
		return _resizable;
	}
	
	/**
	 * Sets whether this component is resizable by the user.
	 * 
	 * @param b {@code true} user can resize the component by 
	 * drag to scale the component, {@code false} user can't.
	 * 
	 * @see #isResizable()
	 */
	public function setResizable( b : Bool) : Void{
		if( _resizable != b )
		{
			_resizable = b;  
			_resizer.setEnabled( isResizable() );
		}
	}
	
	/**
	 * Returns the resizer controller defined in {@link #setResizer}.
	 * 
	 * @see #setResizer
	 */
	public function getResizer() : Resizer
	{
		return _resizer;
	}
	
	/**
	 * Sets the {@link Resizer} controller.
	 * 
	 * <p>By default, use {@code Frame.resizer} one.
	 * 
	 * @param r {@link Resizer} instance
	 * 
	 * @see #getResizer
	 */
	public function setResizer( r : Resizer ) : Void{
		if( r != _resizer )
		{
			_destroyResizer();
			_resizer = r;
			_initResizer();
		}
	}
	
	/**
	 * Return whether need resize widget directly when drag the resizer arrow.
	 * 
	 * @see #setResizeDirectly()
	 */
	public function isResizeDirectly() : Bool{
		return _resizableDirectly;
	}
	
	/**
	 * Indicate whether need resize widget directly when drag the resizer arrow.
	 * 
	 * <p>if set to {@code false}, there will be a rectange to represent then size what 
	 * will be resized to.
	 * 
	 * <p>if set to {@code true}, the widget will be resize directly when drag, but this 
	 * is need more cpu counting.<br>
	 * 
	 * <p>Default is {@coe false}.
	 * 
	 * @see org.aswing.Resizer#setResizeDirectly()
	 */
	public function setResizeDirectly( b : Bool) : Void{
		_resizableDirectly = b;
		_resizer.setResizeDirectly(b);
	}
	
	
	//-------------------------------------------------------------------------
	// Private implementation
	//-------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 * 
	 * @param comp Component where applying resize behaviour.
	 * @param resizer the resizer, default is null means to create a default one.
	 */
	public function new( comp : Component , resizer:Resizer=null)
	{
		if(comp==null) 
		{
			throw new Error("illegal component when insert to ResizerContainer");
			 
		}
		else
		{
			_registerComponent( comp , resizer);
		}
	}	
	
	/**
	 * Registers couple component / controller to the hashmap.
	 * 
	 * @param comp Component where applying resize behaviour.
	 * @param resizer the resizer, default is null means to create a default one.
	 */
	private function _registerComponent( comp : Component , resizer:Resizer=null) : Void{
		_component = comp;
		 
		_resizable = true;
		_resizableDirectly = false;
		if(resizer == null){
			if(getDefaultResizerClass() == null){
				setDefaultResizerClass(DefaultResizer);
			}
			var cl:Class<Dynamic>= getDefaultResizerClass();
			resizer = Type.createInstance( cl,[]);
			if(resizer == null){
				throw new Error("The defaultResizerClass is set wrong!!");
			}
		}
		setResizer( resizer );
	}
	
	private function _initResizer():Void{
		_resizer.setOwner(getComponent());
		_resizer.setEnabled(isResizable());
		_resizer.setResizeDirectly(isResizeDirectly());
	}
	
	private function _destroyResizer():Void{
		if(_resizer != null){
			_resizer.setOwner(null);
			_resizer = null;
		}
	}
	
	/**
	 * Destroy this resizercontroller, set the resizer to null.
	 */
	public function destroy( ) : Void{   
		_destroyResizer();
		_component = null;
	}
	
}