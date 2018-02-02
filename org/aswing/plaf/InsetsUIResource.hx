/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf;

	
import org.aswing.Insets;

/**
 * Insets UI Resource.
 * @author paling
 */
class InsetsUIResource extends Insets implements UIResource
{
	public function new(top:Int=0, left:Int=0, bottom:Int=0, right:Int=0)
	{
		super(top, left, bottom, right);
	}
	
	/**
	 * Create a insets ui resource with a insets.
	 */
	public function createInsetsResource(insets:Insets):InsetsUIResource{
		return new InsetsUIResource(insets.top, insets.left, insets.bottom, insets.right);
	}
	
}