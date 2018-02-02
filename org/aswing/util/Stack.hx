/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.util;


/**
 * The <code>Stack</code> class represents a last-in-first-out 
 * (LIFO) stack of objects. It extends class <tt>Vector</tt> with five 
 * operations that allow a vector to be treated as a stack. The usual 
 * <tt>push</tt> and <tt>pop</tt> operations are provided, as well as a
 * method to <tt>peek</tt> at the top item on the stack, a method to test 
 * for whether the stack is <tt>empty</tt>, and a method to <tt>search</tt> 
 * the stack for an item and discover how far it is from the top.
 * <p>
 * When a stack is first created, it contains no items. 
 * @author paling
 */	
class Stack extends ArrayList
{
	/**
     * Creates an empty Stack.
     */
	public function new() {
		super();
	}
	
    /**
     * Tests if this stack is empty.
     *
     * @return  <code>true</code> if and only if this stack contains 
     *          no items; <code>false</code> otherwise.
     */
	public function empty():Bool{
		return _elements.length == 0;
	}
	
	/**
     * Looks at the object at the top of this stack without removing it 
     * from the stack. 
     *
     * @return     the object at the top of this stack (the last item 
     *             of the <tt>Vector</tt> object). undefined is there is no items.
	 */
	public function peek():Dynamic{
		return _elements[_elements.length-1];
	}
	
	/**
     * Removes the object at the top of this stack and returns that 
     * object as the value of this function. 
     *
     * @return     The object at the top of this stack (the last item 
     *             of the <tt>Vector</tt> object). undefined if there is no items.
     */
	override public function pop():Dynamic{
		return _elements.pop();
	}
	
	/**
     * Pushes an item onto the top of this stack. This has exactly 
     * the same effect as:
     * <blockquote><pre>
     * append(item)</pre></blockquote>
     *
     * @param   item   the item to be pushed onto this stack.
     * @return  the <code>item</code> argument.
	 */
	public function push(item:Dynamic):Dynamic{
		_elements.push(item);
		return item;
	}
	

    /**
     * Returns the 1-based position where an object is on this stack. 
     * If the object <tt>o</tt> occurs as an item in this stack, this 
     * method returns the distance from the top of the stack of the 
     * occurrence nearest the top of the stack; the topmost item on the 
     * stack is considered to be at distance <tt>1</tt>. The <tt>equals</tt> 
     * method is used to compare <tt>o</tt> to the 
     * items in this stack.
     *
     * @param   o   the desired object.
     * @return  the 1-based position from the top of the stack where 
     *          the object is located; the return value <code>-1</code>
     *          indicates that the object is not on the stack.
     */	
	public function search(o:Dynamic):Int{
		var i:Int= lastIndexOf(o);
		if (i >= 0) {
		    return size() - i;
		}
		return -1;
	}
}