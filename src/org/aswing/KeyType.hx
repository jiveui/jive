/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * KeyType defined with description representing the key sequence with a string, 
 * codeSequence contains the key codes sequence.
 * Same codeSequence will be considered as same key definition.
 * <p>
 * For example "C" and [67] mean the C key on the key board.
 * "Ctrl+C" and [17, 67] mean the first Ctrl and then C keys.
 * <p>
 * Thanks Romain for his Fever{@link http://fever.riaforge.org} accelerator framworks implementation, 
 * this is a simpler implementation study from his.
 * 
 * @see org.aswing.Keyboard
 * @see org.aswing.KeySequence
 * @author paling
 */	
interface KeyType{
	
	/**
	 * Returns the key code sequence. Same code sequence be track as same key definition.
	 * @return an array(uint[]) that contains the key codes sequence
	 */
	function getCodeSequence():Array<Dynamic>;	
	
	/**
	 * Returns the string that represent the key sequence.
	 * @return string that represent the key sequence. 
	 */
	function getDescription():String;
}