package org.aswing;

 


/**
 * <code>JLayeredPane</code> adds depth to a JFC/Swing container,
 * allowing components to overlap each other when needed.
 * An <code>Integer</code> object specifies each component's depth in the
 * container, where higher-numbered components sit &quot;on top&quot; of other
 * components.
 * For task-oriented documentation and examples of using layered panes see
 * <a href="http://java.sun.com/docs/books/tutorial/uiswing/components/layeredpane.html">How to Use a Layered Pane</a>,
 * a section in <em>The Java Tutorial</em>.
 * <P>
 * <TABLE ALIGN="RIGHT" BORDER="0" SUMMARY="layout">
 * <TR>
 *   <TD ALIGN="CENTER">
 *     <P ALIGN="CENTER"><IMG SRC="doc-files/JLayeredPane-1.gif"
 *     alt="The following text describes this image."
 *     WIDTH="269" HEIGHT="264" ALIGN="BOTTOM" BORDER="0">
 *   </TD>
 * </TR>
 * </TABLE>
 * For convenience, <code>JLayeredPane</code> divides the depth-range
 * into several different layers. Putting a component into one of those
 * layers makes it easy to ensure that components overlap properly,
 * without having to worry about specifying numbers for specific depths:
 * <DL>
 *    <DT><FONT SIZE="2">DEFAULT_LAYER</FONT></DT>
 *         <DD>The standard layer, where most components go. This the bottommost
 *         layer.
 *    <DT><FONT SIZE="2">PALETTE_LAYER</FONT></DT>
 *         <DD>The palette layer sits over the default layer. Useful for floating
 *         toolbars and palettes, so they can be positioned above other components.
 *    <DT><FONT SIZE="2">MODAL_LAYER</FONT></DT>
 *         <DD>The layer used for modal dialogs. They will appear on top of any
 *         toolbars, palettes, or standard components in the container.
 *    <DT><FONT SIZE="2">POPUP_LAYER</FONT></DT>
 *         <DD>The popup layer displays above dialogs. That way, the popup windows
 *         associated with combo boxes, tooltips, and other help text will appear
 *         above the component, palette, or dialog that generated them.
 *    <DT><FONT SIZE="2">DRAG_LAYER</FONT></DT>
 *         <DD>When dragging a component, reassigning it to the drag layer ensures
 *         that it is positioned over every other component in the container. When
 *         finished dragging, it can be reassigned to its normal layer.
 * </DL>
 * The <code>JLayeredPane</code> methods <code>moveToFront(Component)</code>,
 * <code>moveToBack(Component)</code> and <code>setPosition</code> can be used
 * to reposition a component within its layer. The <code>setLayer</code> method
 * can also be used to change the component's current layer.
 *
 * <h2>Details</h2>
 * <code>JLayeredPane</code> manages its list of children like
 * <code>Container</code>, but allows for the definition of a several
 * layers within itself. Children in the same layer are managed exactly
 * like the normal <code>Container</code> object,
 * with the added feature that when children components overlap, children
 * in higher layers display above the children in lower layers.
 * <p>
 * Each layer is a distinct integer number. The layer attribute can be set
 * on a <code>Component</code> by passing an <code>Integer</code>
 * object during the add call.<br> For example:
 * <PRE>
 *     layeredPane.append(child, JLayeredPane.DEFAULT_LAYER);
 * or
 *     layeredPane.append(child,  10 );
 * </PRE>
 * The layer attribute can also be set on a Component by calling<PRE>
 *     layeredPaneParent.setLayer(child, 10)</PRE>
 * on the <code>JLayeredPane</code> that is the parent of component. The layer
 * should be set <i>before</i> adding the child to the parent.
 * <p>
 * Higher number layers display above lower number layers. So, using
 * numbers for the layers and letters for individual components, a
 * representative list order would look like this:<PRE>
 *       5a, 5b, 5c, 2a, 2b, 2c, 1a </PRE>
 * where the leftmost components are closest to the top of the display.
 * <p>
 * A component can be moved to the top or bottom position within its
 * layer by calling <code>moveToFront</code> or <code>moveToBack</code>.
 * <p>
 * The position of a component within a layer can also be specified directly.
 * Valid positions range from 0 up to one less than the number of
 * components in that layer. A value of -1 indicates the bottommost
 * position. A value of 0 indicates the topmost position. Unlike layer
 * numbers, higher position values are <i>lower</i> in the display.
 * <blockquote>
 * <b>Note:</b> This sequence (defined by java.awt.Container) is the reverse
 * of the layer numbering sequence. Usually though, you will use <code>moveToFront</code>,
 * <code>moveToBack</code>, and <code>setLayer</code>.
 * </blockquote>
 * Here are some examples using the method add(Component, layer, position):
 * Calling add(5x, 5, -1) results in:<PRE>
 *       5a, 5b, 5c, 5x, 2a, 2b, 2c, 1a </PRE>
 *
 * Calling add(5z, 5, 2) results in:<PRE>
 *       5a, 5b, 5z, 5c, 5x, 2a, 2b, 2c, 1a </PRE>
 *
 * Calling add(3a, 3, 7) results in:<PRE>
 *       5a, 5b, 5z, 5c, 5x, 3a, 2a, 2b, 2c, 1a </PRE>
 *
 * Using normal paint/event mechanics results in 1a appearing at the bottom
 * and 5a being above all other components.
 * <p>
 * <b>Note:</b> that these layers are simply a logical construct and LayoutManagers
 * will affect all child components of this container without regard for
 * layer settings.
 * <p>
 * <strong>Warning:</strong> Swing is not thread safe. For more
 * information see <a
 * href="package-summary.html#threading">Swing's Threading
 * Policy</a>.
 * <p>
 * <strong>Warning:</strong>
 * Serialized objects of this class will not be compatible with
 * future Swing releases. The current serialization support is
 * appropriate for short term storage or RMI between applications running
 * the same version of Swing.  As of 1.4, support for long term storage
 * of all JavaBeans<sup><font size="-2">TM</font></sup>
 * has been added to the <code>java.beans</code> package.
 * Please see {@link java.beans.XMLEncoder}.
 *
 * @author paling
 */
  class JLayeredPane extends   Container  {
    /// Watch the values in getObjectForLayer()
    /** Convenience object defining the Default layer. Equivalent to new Integer(0).*/
    inline static public var    DEFAULT_LAYER:Int = 0 ;
    /** Convenience object defining the Palette layer. Equivalent to new Integer(100).*/
    inline static public var  PALETTE_LAYER :Int=  100 ;
    /** Convenience object defining the Modal layer. Equivalent to new Integer(200).*/
    inline static public var   MODAL_LAYER:Int =  200 ;
    /** Convenience object defining the Popup layer. Equivalent to new Integer(300).*/
    inline static public var   POPUP_LAYER :Int=  300 ;
    /** Convenience object defining the Drag layer. Equivalent to new Integer(400).*/
    inline static public var   DRAG_LAYER :Int=  400 ;
    /** Convenience object defining the Frame Content layer.
      * This layer is normally only use to positon the contentPane and menuBar
      * components of JFrame.
      * Equivalent to new Integer(-30000).
      * @see JFrame
      */
    inline static public var   FRAME_CONTENT_LAYER:Int =  -30000 ;

    /** Bound property */
	inline static public var  LAYER_PROPERTY :String = "layeredContainerLayer";
	
	
	//////////////////////////////////////////////////////////////////////////////
//// New methods for managing layers
//////////////////////////////////////////////////////////////////////////////
    /** Sets the layer property on a JComponent. This method does not cause
      * any side effects like setLayer() (painting, add/remove, etc).
      * Normally you should use the instance method setLayer(), in order to
      * get the desired side-effects (like repainting).
      *
      * @param c      the JComponent to move
      * @param layer  an int specifying the layer to move it to
      * @see #setLayer
      */
    public static  function putLayerProperty(  c:Component,   layer:Int):Void {
        /// MAKE SURE THIS AND setLayer(Component c, int layer, int position)  are SYNCED
        var layerObj:Int;

        layerObj =  layer ;
        c.putClientProperty(LAYER_PROPERTY, layerObj);
    }

    /** Gets the layer property for a JComponent, it
      * does not cause any side effects like setLayer(). (painting, add/remove, etc)
      * Normally you should use the instance method getLayer().
      *
      * @param c  the JComponent to check
      * @return   an int specifying the component's layer
      */
    public static function getLayerProperty(  c:Component) :Int{
        var i :Int;
        if((i = cast( c.getClientProperty(LAYER_PROPERTY),Int) )!= 0)
            return i ;
        return DEFAULT_LAYER ;
    }

    /** Convenience method that returns the first JLayeredPane which
      * contains the specified component. Note that all JFrames have a
      * JLayeredPane at their root, so any component in a JFrame will
      * have a JLayeredPane parent.
      *
      * @param c the Component to check
      * @return the JLayeredPane that contains the component, or
      *         null if no JLayeredPane is found in the component
      *         hierarchy
      * @see JFrame
      * @see JRootPane
      */
    public static function getLayeredPaneAbove( c:Component):JLayeredPane {
        if(c == null) return null;

        var parent:Component = c.getParent();
        while(parent != null && !Std.is(parent , JLayeredPane))
            parent = parent.getParent();
        return cast(parent,JLayeredPane);
    }
	
	
	
    // Maptable to store layer values for non-JComponent components
    private var componentToLayer:Map < Int > ;//<Component,Int >
    private var optimizedDrawingPossible:Bool;


//////////////////////////////////////////////////////////////////////////////
//// Container Override methods
//////////////////////////////////////////////////////////////////////////////
    /** Create a new JLayeredPane */
    public  function new() {
		super();
		optimizedDrawingPossible = true;
		componentToLayer = new Map <Int>();
        setLayout(new EmptyLayout());
    }

    private  function validateOptimizedDrawing() :Void{
        var layeredComponentFound:Bool = false;
		 var layer:Int;

            for (  c in getComponents()) {
                layer = 0;

                if( Std.is(c , Component) && (layer = cast( c,Component).getClientProperty(LAYER_PROPERTY)) != 0) 
                {
                    if(layer != 0 && layer==(FRAME_CONTENT_LAYER))
                        continue;
                    layeredComponentFound = true;
                    break;
                }
            }
        

        if(layeredComponentFound)
        {
			 optimizedDrawingPossible = false;
		}
        else
        {
			   optimizedDrawingPossible = true;
		}
    }
	override private function insertImp(index:Int, comp:Component, constraints:Dynamic=null):Void{
          var layer:Int;
        var pos:Int;

        if(Std.is(constraints , Int)) {
            layer = cast( constraints, Int) ;
            setLayer(comp, layer);
        } else
            layer = getLayer(comp);

        pos = insertIndexForLayer(null,layer, index);
        super.insertImp(pos,comp, constraints );
        comp.validate();
        comp.repaint();
        validateOptimizedDrawing();
    }

    /**
     * Remove the indexed component from this pane.
     * This is the absolute index, ignoring layers.
     *
     * @param index  an int specifying the component to remove
     * @see #getIndexOf
     */
	 
    override public  function removeAt(  index:Int) :Component {
        var c :Component= getComponent(index);
        super.removeAt(index);
        if (c != null && !Std.is(c , Component)) {
            getComponentToLayer().remove(c.getAwmlIndex());
        }
        validateOptimizedDrawing();
		return c;
    }

    /**
     * Removes all the components from this container.
     *
     * @since 1.5
     */
    override public function removeAll():Void {
     
        componentToLayer = new Map <Int>();
        super.removeAll();
    }

    /**
     * Returns false if components in the pane can overlap, which makes
     * optimized drawing impossible. Otherwise, returns true.
     *
     * @return false if components can overlap, else true
     * @see JComponent#isOptimizedDrawingEnabled
     */
    public function isOptimizedDrawingEnabled() :Bool{
        return optimizedDrawingPossible;
    }



 

    /** Sets the layer attribute for the specified component and
      * also sets its position within that layer.
      *
      * @param c         the Component to set the layer for
      * @param layer     an int specifying the layer to set, where
      *                  lower numbers are closer to the bottom
      * @param position  an int specifying the position within the
      *                  layer, where 0 is the topmost position and -1
      *                  is the bottommost position
      */
    public  function  setLayer(  c:Component,   layer:Int,   ?position:Int=-1):Void  {
        var layerObj:Int;
        layerObj = getObjectForLayer(layer);

        if(layer == getLayer(c) && position == getPosition(c)) {
                paint(c.getComBounds());
            return;
        }

        /// MAKE SURE THIS AND putLayer(JComponent c, int layer) are SYNCED
        if(Std.is(c , Component))
            cast( c , Component).putClientProperty(LAYER_PROPERTY, layerObj);
        else
            getComponentToLayer().set( c.getAwmlIndex(), layerObj);

        if(c.getParent() == null || c.getParent() != this) {
            paint(c.getComBounds());
            return;
        }

        var index :Int= insertIndexForLayer(c, layer, position);
		this.setChildIndex(c, index);//setComponentZOrder
        paint(c.getComBounds());
    }

    /**
     * Returns the layer attribute for the specified Component.
     *
     * @param c  the Component to check
     * @return an int specifying the component's current layer
     */
    public  function getLayer( c:Component):Int {
        var i:Int;
        if(Std.is(c , Component))
            i = cast( c , Component).getClientProperty(LAYER_PROPERTY);
        else
            i = getComponentToLayer().get( c.getAwmlIndex());

        if(i == 0)
            return DEFAULT_LAYER ;
        return i ;
    }

    /**
     * Returns the index of the specified Component.
     * This is the absolute index, ignoring layers.
     * Index numbers, like position numbers, have the topmost component
     * at index zero. Larger numbers are closer to the bottom.
     *
     * @param c  the Component to check
     * @return an int specifying the component's index
     */
    public function getIndexOf( c:Component):Int {
 
		var count:Int;

        count = getComponentCount();
        for(i in 0...count) {
            if(c == getComponent(i))
                return i;
        }
        return -1;
    }
    /**
     * Moves the component to the top of the components in its current layer
     * (position 0).
     *
     * @param c the Component to move
     * @see #setPosition(Component, int)
     */
    public  function moveToFront( c:Component):Void {
        setPosition(c, 0);
    }

    /**
     * Moves the component to the bottom of the components in its current layer
     * (position -1).
     *
     * @param c the Component to move
     * @see #setPosition(Component, int)
     */
    public  function moveToBack(  c:Component):Void {
        setPosition(c, -1);
    }

    /**
     * Moves the component to <code>position</code> within its current layer,
     * where 0 is the topmost position within the layer and -1 is the bottommost
     * position.
     * <p>
     * <b>Note:</b> Position numbering is defined by java.awt.Container, and
     * is the opposite of layer numbering. Lower position numbers are closer
     * to the top (0 is topmost), and higher position numbers are closer to
     * the bottom.
     *
     * @param c         the Component to move
     * @param position  an int in the range -1..N-1, where N is the number of
     *                  components in the component's current layer
     */
    public  function setPosition(  c:Component,   position:Int):Void{
        setLayer(c, getLayer(c), position);
    }

    /**
     * Get the relative position of the component within its layer.
     *
     * @param c  the Component to check
     * @return an int giving the component's position, where 0 is the
     *         topmost position and the highest index value = the count
     *         count of components at that layer, minus 1
     *
     * @see #getComponentCountInLayer
     */
    public function getPosition(  c:Component):Int {
        var i:Int= 0;
		var startLayer:Int= 0;
		var curLayer:Int= 0; 
		var startLocation:Int= 0; 
		var pos :Int= 0;

        getComponentCount();
        startLocation = getIndexOf(c);

        if(startLocation == -1)
            return -1;

        startLayer = getLayer(c);
		
		i = startLocation - 1;
        while( i >= 0 ) {
            curLayer = getLayer(getComponent(i));
            if(curLayer == startLayer)
                pos++;
            else
                return pos;
			i--;
        }
        return pos;
    }

    /** Returns the highest layer value from all current children.
      * Returns 0 if there are no children.
      *
      * @return an int indicating the layer of the topmost component in the
      *         pane, or zero if there are no children
      */
    public  function highestLayer():Int  {
        if(getComponentCount() > 0)
            return getLayer(getComponent(0));
        return 0;
    }

    /** Returns the lowest layer value from all current children.
      * Returns 0 if there are no children.
      *
      * @return an int indicating the layer of the bottommost component in the
      *         pane, or zero if there are no children
      */
    public  function lowestLayer() :Int {
        var count: Int  = getComponentCount();
        if(count > 0)
            return getLayer(getComponent(count-1));
        return 0;
    }

    /**
     * Returns the number of children currently in the specified layer.
     *
     * @param layer  an int specifying the layer to check
     * @return an int specifying the number of components in that layer
     */
    public  function getComponentCountInLayer(  layer:Int ) :Int {
        var count:Int , curLayer:Int ;
        var layerCount = 0;

        count = getComponentCount();
        for(i in 0... count ) {
            curLayer = getLayer(getComponent(i));
            if(curLayer == layer) {
                layerCount++;
            /// Short circut the counting when we have them all
            } else if(layerCount > 0 || curLayer < layer) {
                break;
            }
        }

        return layerCount;
    }

    /**
     * Returns an array of the components in the specified layer.
     *
     * @param layer  an int specifying the layer to check
     * @return an array of Components contained in that layer
     */
    public function getComponentsInLayer(  layer:Int):Array<Component> {
        var count:Int, curLayer:Int;
        var layerCount:Int = 0;
        var results:Array<Component>;

        results = new Array<Component>();// Component[getComponentCountInLayer(layer)];
        count = getComponentCount();
        for(i in 0...count) {
            curLayer = getLayer(getComponent(i));
            if(curLayer == layer) {
                results[layerCount++] = getComponent(i);
            /// Short circut the counting when we have them all
            } else if(layerCount > 0 || curLayer < layer) {
                break;
            }
        }

        return results;
    }

  

//////////////////////////////////////////////////////////////////////////////
//// Implementation Details
//////////////////////////////////////////////////////////////////////////////

    /**
     * Returns the hashtable that maps components to layers.
     *
     * @return the Maptable used to map components to their layers
     */
    private  function getComponentToLayer():haxe.ds.IntMap<Int> {
        if(componentToLayer == null)
            componentToLayer = new haxe.ds.IntMap<Int>();
        return componentToLayer;
    }

    /**
     * Returns the Integer object associated with a specified layer.
     *
     * @param layer an int specifying the layer
     * @return an Integer object for that layer
     */
    private  function getObjectForLayer(  layer:Int):Int {
        var layerObj:Int;
        switch(layer) {
        case 0:
            layerObj = DEFAULT_LAYER;
           
        case 100:
            layerObj = PALETTE_LAYER;
           
        case 200:
            layerObj = MODAL_LAYER;
            
        case 300:
            layerObj = POPUP_LAYER;
             
        case 400:
            layerObj = DRAG_LAYER;
         
        default:
            layerObj = layer ;
        }
        return layerObj;
    }
 
    /**
     * This method is an extended version of insertIndexForLayer()
     * to support setLayer which uses Container.setZOrder which does
     * not remove the component from the containment heirarchy though
     * we need to ignore it when calculating the insertion index.
     *
     * @param comp      component to ignore when determining index
     * @param layer     an int specifying the layer
     * @param position  an int specifying the position within the layer
     * @return an int giving the (absolute) insertion-index
     *
     * @see #getIndexOf
     */
    private  function insertIndexForLayer(? comp:Component=null,   layer:Int,   position:Int):Int{
        var count:Int, curLayer:Int;
        var layerStart:Int = -1;
        var layerEnd:Int = -1;
        var componentCount:Int = getComponentCount();

        var compList :Array<Component>=  new Array<Component>();
        for (  index in 0...componentCount ) {
            if (getComponent(index) != comp) {
                compList.push(getComponent(index));
            }
        }

        count = compList.length;
        for (i in 0...count) {
            curLayer = getLayer(compList[i]);
            if (layerStart == -1 && curLayer == layer) {
                layerStart = i;
            }
            if (curLayer < layer) {
                if (i == 0) {
                    // layer is greater than any current layer
                    // [ ASSERT(layer > highestLayer()) ]
                    layerStart = 0;
                    layerEnd = 0;
                } else {
                    layerEnd = i;
                }
                break;
            }
        }

        // layer requested is lower than any current layer
        // [ ASSERT(layer < lowestLayer()) ]
        // put it on the bottom of the stack
        if (layerStart == -1 && layerEnd == -1)
            return count;

        // In the case of a single layer entry handle the degenerative cases
        if (layerStart != -1 && layerEnd == -1)
            layerEnd = count;

        if (layerEnd != -1 && layerStart == -1)
            layerStart = layerEnd;

        // If we are adding to the bottom, return the last element
        if (position == -1)
            return layerEnd;

        // Otherwise make sure the requested position falls in the
        // proper range
        if (position > -1 && layerStart + position <= layerEnd)
            return layerStart + position;

        // Otherwise return the end of the layer
        return layerEnd;
    }

 
}