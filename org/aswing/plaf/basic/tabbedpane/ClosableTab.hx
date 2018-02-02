package org.aswing.plaf.basic.tabbedpane;


import org.aswing.Component;

/**
 * The closable tab has a close button.
 * @author paling
 */
interface ClosableTab extends Tab{
	
	function getCloseButton():Component;
	
}