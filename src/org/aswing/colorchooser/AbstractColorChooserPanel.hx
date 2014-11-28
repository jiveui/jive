/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.colorchooser;
 
import org.aswing.ASColor;
import org.aswing.colorchooser.ColorSelectionModel;
import org.aswing.colorchooser.DefaultColorSelectionModel;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.event.InteractiveEvent;
	import org.aswing.event.ColorChooserEvent;
	/**
 * Dispatched when user adjusting to a new color
 * @eventType org.aswing.event.ColorChooserEvent.COLOR_ADJUSTING
 * @see org.aswing.AbstractButton#addActionListener()
 */
// [Event(name="colorAdjusting", type="org.aswing.event.ColorChooserEvent")]

/**
 * Dispatched when the color selection changed. 
 * @see ColorSelectionModel
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]
/**
 * @author paling
 */
class AbstractColorChooserPanel extends Container {
	private var alphaSectionVisible:Bool;
	private var hexSectionVisible:Bool;
	private var noColorSectionVisible:Bool;
	private var model:ColorSelectionModel;
	
	public function new() {
		super();
		alphaSectionVisible = true;
		hexSectionVisible   = true;
		noColorSectionVisible = false;
		setModel(new DefaultColorSelectionModel());
	}
	
	/**
	 * Sets the color selection model to this chooser panel.
	 * @param model the color selection model
	 */
	public function setModel(model:ColorSelectionModel):Void{
		if(model == null) return;
		if(this.model != model){
			uninstallListener(model);
			this.model = model;
			installListener(model);
			repaint();
		}
	}
	
	private function installListener(model:ColorSelectionModel):Void{
		model.addChangeListener(__modelValueChanged);
		model.addColorAdjustingListener(__colorAdjusting);
	}
	
	private function uninstallListener(model:ColorSelectionModel):Void{
		model.removeChangeListener(__modelValueChanged);
		model.removeColorAdjustingListener(__colorAdjusting);
	}
	
	private function __modelValueChanged(e:InteractiveEvent):Void{
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED));
	}
	private function __colorAdjusting(e:ColorChooserEvent):Void{
		dispatchEvent(new ColorChooserEvent(ColorChooserEvent.COLOR_ADJUSTING, e.getColor()));
	}
	
	/**
	 * Returns the color selection model of this chooser panel
	 * @return the color selection model of this chooser panel
	 */
	public function getModel():ColorSelectionModel{
		return model;
	}
	
	/**
	 * Sets the color selected, null indicate that no color is selected.
	 * @param c the color to be selected, null indicate no color to be selected.
	 */
	public function setSelectedColor(c:ASColor):Void{
		getModel().setSelectedColor(c);
	}
	
	/**
	 * Returns the color selected, null will be return if there is no color selected.
	 * @return the color selected, or null.
	 */
	public function getSelectedColor():ASColor{
		return getModel().getSelectedColor();
	}
	
	/**
	 * Sets whether showing the alpha editing section.
	 * <p>
	 * Default value is true.
	 * @param b true to show the alpha editing section, false no.
	 */
	public function setAlphaSectionVisible(b:Bool):Void{
		if(alphaSectionVisible != b){
			alphaSectionVisible = b;
			repaint();
		}
	}
	
	/**
	 * Returns true if the alpha editing section is shown, otherwise false.
	 * @return true if the alpha editing section is shown, otherwise false.
	 */
	public function isAlphaSectionVisible():Bool{
		return alphaSectionVisible;
	}
	
	/**
	 * Sets whether showing the hex editing section.
	 * <p>
	 * Default value is true.
	 * @param b true to show the hex editing section, false no.
	 */	
	public function setHexSectionVisible(b:Bool):Void{
		if(hexSectionVisible != b){
			hexSectionVisible = b;
			repaint();
		}
	}
	
	/**
	 * Returns true if the hex editing section is shown, otherwise false.
	 * @return true if the hex editing section is shown, otherwise false.
	 */	
	public function isHexSectionVisible():Bool{
		return hexSectionVisible;
	}	
	
	/**
	 * Sets whether showing the no color toggle button section. Depend on LAF, not 
	 * every LAFs will implement this functionity.
	 * <p>
	 * Default value is false.
	 * @param b true to show the no color toggle button section, false no.
	 */	
	public function setNoColorSectionVisible(b:Bool):Void{
		if(noColorSectionVisible != b){
			noColorSectionVisible = b;
			repaint();
		}
	}
	
	/**
	 * Returns true if the  no color toggle button is shown, otherwise false.
	 * @return true if the  no color toggle button is shown, otherwise false.
	 */	
	public function isNoColorSectionVisible():Bool{
		return noColorSectionVisible;
	}		
}