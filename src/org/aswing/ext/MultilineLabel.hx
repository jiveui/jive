/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.ext;


import org.aswing.JTextArea;

/**
 * MutilineLabel performances just like a label that wordwrap and multiline. 
 * It is simulated by a <code>JTextArea</code> with no border no backgorund decorator and background not opaque.
 * By default it is wrodwrap and selectable.
 * @author paling
 */
class MultilineLabel extends JTextArea{
	
	public function new(text:String="", rows:Int=0, columns:Int=0){
		super(text, rows, columns);
		setWordWrap(true);
		setBorder(null);
		setBackgroundDecorator(null);
		setOpaque(false);
		setEditable(false);
	}
	
}