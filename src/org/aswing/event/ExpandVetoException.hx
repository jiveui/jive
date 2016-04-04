/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;
import org.aswing.error.Error;
 
	
/**
 * Exception used to stop and expand/collapse from happening.
 * @author paling
 */
class ExpandVetoException extends Error {
	
	public function new(message : String) {
		super(message);
	 
	}

}