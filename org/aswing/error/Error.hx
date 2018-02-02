/**
 * ...
 * @author palp
 */

package  org.aswing.error;

class Error
{
	var errorID : Int;
	var message : Dynamic;
	var name : Dynamic;

	public function new(?inMessage : Dynamic, id : Dynamic = 0)
	{
	  message = inMessage;
	  errorID = id;
	}
	public function toString() : String { return message; }
	function getStackTrace() : String { return ""; }
}
