/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * The default list cell factory for JList.
 * @see org.aswing.JList
 * @author paling
 */
class DefaultListCellFactory extends DefaultListTextCellFactory{
	
	public function new(shareCelles:Bool=true, sameHeight:Bool=true){
		super(DefaultListCell, shareCelles, sameHeight);
	}
}