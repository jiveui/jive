/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.error;
import org.aswing.error.Error;
/**
 * This error indicates that an abstract class's abstract method missing overriden error.
 */
class ImpMissError extends Error
{
	public function new(){
		super("Subclass should override this method to do implementation!!");
	}
}