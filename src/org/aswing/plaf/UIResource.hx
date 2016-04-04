package org.aswing.plaf;

	
/**
 * This interface is used to mark objects created by ComponentUI delegates.
 * The <code>ComponentUI.installUI()</code> and 
 * <code>ComponentUI.uninstallUI()</code> methods can use this interface
 * to decide if a properties value has been overridden.  For example, the
 * JPanel border property is initialized by BasicPanelUI.installUI(),
 * only if it's initial value is an UIResource instance:
 * <pre>
 * if (panel.getBorder() is UIResource) {
 *     panel.setBorder(UIManager.getBorder("Panel.border"));
 * }
 * </pre>
 * At uninstallUI() time we will not reset the property, because it will 
 * be replaced by next UI installing.
 * 
 * Some other type value like Numbers, Booleans, there will be method in the Component 
 * indicated that if is it set by user or LAFs, for example:
 * <pre>
 * if (!panel.isOpaqueSet()) {
 *     panel.setOpaque(UIManager.getBoolean("Panel.opaque"));
 *     panel.setOpaqueSet(false);
 * }
 * </pre>
 * @see EmptyUIResources
 * @see ComponentUI
 * @author paling
 */	
interface UIResource
{
	
}