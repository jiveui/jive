/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * The default list cell factory for JComboBox drop down list.
 * @see org.aswing.JComboBox
 * @author paling
 */
class DefaultComboBoxListCellFactory extends DefaultListTextCellFactory{
	
	public function new(shareCelles:Bool=true, sameHeight:Bool=true){
		super(DefaultComboBoxListCell, shareCelles, sameHeight);
	}
}