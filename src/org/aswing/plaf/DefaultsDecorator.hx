package org.aswing.plaf;

	
/**
 * The decorator that will use defaults properties.
 */
interface DefaultsDecorator{
	
	/**
	 * Sets the defaults properties owner.
	 * Which the owner.getDefault() will be called.
	 */
	function setDefaultsOwner(owner:ComponentUI):Void;
	
}