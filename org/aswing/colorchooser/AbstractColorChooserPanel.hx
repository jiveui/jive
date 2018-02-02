/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.colorchooser;

import bindx.Bind;
import org.aswing.ASColor;
import org.aswing.colorchooser.ColorSelectionModel;
import org.aswing.colorchooser.DefaultColorSelectionModel;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.event.InteractiveEvent;
import org.aswing.event.ColorChooserEvent;
/**
 * @author paling
 */
@:event("org.aswing.event.ColorChooserEvent.COLOR_ADJUSTING", "Dispatched when user adjusting to a new color")
@:event("org.aswing.event.InteractiveEvent.STATE_CHANGED", "Dispatched when the color selection changed")
class AbstractColorChooserPanel extends Container implements bindx.IBindable{

    /**
	 * Whether showing the alpha editing section.
	 *
	 * Default value is true.
	 */
    public var alphaSectionVisible(get, set): Bool;
    private var _alphaSectionVisible: Bool;
    private function get_alphaSectionVisible(): Bool { return isAlphaSectionVisible(); }
    private function set_alphaSectionVisible(v: Bool): Bool { setAlphaSectionVisible(v); return v; }

    /**
	 * Whether showing the hex editing section.
	 *
	 * Default value is true.
	 */
    public var hexSectionVisible(get, set): Bool;
    private var _hexSectionVisible: Bool;
    private function get_hexSectionVisible(): Bool { return isHexSectionVisible(); }
    private function set_hexSectionVisible(v: Bool): Bool { setHexSectionVisible(v); return v; }

    /**
	 * Whether showing the no color toggle button section.
	 *
	 * Depend on LAF, not
	 * every LAFs will implement this functionity.
	 *
	 * Default value is false.
	 */
    public var noColorSectionVisible(get, set): Bool;
    private var _noColorSectionVisible: Bool;
    private function get_noColorSectionVisible(): Bool { return isNoColorSectionVisible(); }
    private function set_noColorSectionVisible(v: Bool): Bool { setNoColorSectionVisible(v); return v; }

	/**
    * The color selection model of this chooser panel
    **/
    public var model(get, set): ColorSelectionModel;
    private var _model:ColorSelectionModel;
    private function get_model(): ColorSelectionModel { return getModel(); }
    private function set_model(v: ColorSelectionModel): ColorSelectionModel { setModel(v); return v; }

    /**
	 * The color selected, null will be return if there is no color selected.
	 */
    @:bindable public var selectedColor(get, set): ASColor;
    private function get_selectedColor(): ASColor { return getSelectedColor(); }
    private function set_selectedColor(v: ASColor): ASColor { setSelectedColor(v); return v; }

	public function new() {
		super();
		_alphaSectionVisible = true;
		_hexSectionVisible   = true;
		_noColorSectionVisible = false;
		setModel(new DefaultColorSelectionModel());
	}
	
	/**
	 * Sets the color selection model to this chooser panel.
	 * @param model the color selection model
	 */
    @:dox(hide)
	public function setModel(model:ColorSelectionModel):Void{
		if(model == null) return;
		if(this._model != model){
			uninstallListener(model);
			this._model = model;
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
        Bind.notify(this.selectedColor, null, selectedColor);
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED));
	}
	private function __colorAdjusting(e:ColorChooserEvent):Void{
		dispatchEvent(new ColorChooserEvent(ColorChooserEvent.COLOR_ADJUSTING, e.getColor()));
	}
	
	/**
	 * Returns the color selection model of this chooser panel
	 * @return the color selection model of this chooser panel
	 */
    @:dox(hide)
	public function getModel():ColorSelectionModel{
		return _model;
	}
	
	/**
	 * Sets the color selected, null indicate that no color is selected.
	 * @param c the color to be selected, null indicate no color to be selected.
	 */
    @:dox(hide)
	public function setSelectedColor(c:ASColor):Void{
		getModel().setSelectedColor(c);
	}
	
	/**
	 * Returns the color selected, null will be return if there is no color selected.
	 * @return the color selected, or null.
	 */
    @:dox(hide)
	public function getSelectedColor():ASColor{
		return getModel().getSelectedColor();
	}
	
	/**
	 * Sets whether showing the alpha editing section.
	 * <p>
	 * Default value is true.
	 * @param b true to show the alpha editing section, false no.
	 */
    @:dox(hide)
	public function setAlphaSectionVisible(b:Bool):Void{
		if(_alphaSectionVisible != b){
			_alphaSectionVisible = b;
			repaint();
		}
	}
	
	/**
	 * Returns true if the alpha editing section is shown, otherwise false.
	 * @return true if the alpha editing section is shown, otherwise false.
	 */
    @:dox(hide)
	public function isAlphaSectionVisible():Bool{
		return _alphaSectionVisible;
	}
	
	/**
	 * Sets whether showing the hex editing section.
	 * <p>
	 * Default value is true.
	 * @param b true to show the hex editing section, false no.
	 */
    @:dox(hide)
	public function setHexSectionVisible(b:Bool):Void{
		if(_hexSectionVisible != b){
			_hexSectionVisible = b;
			repaint();
		}
	}
	
	/**
	 * Returns true if the hex editing section is shown, otherwise false.
	 * @return true if the hex editing section is shown, otherwise false.
	 */
    @:dox(hide)
	public function isHexSectionVisible():Bool{
		return _hexSectionVisible;
	}	
	
	/**
	 * Sets whether showing the no color toggle button section. Depend on LAF, not 
	 * every LAFs will implement this functionity.
	 * <p>
	 * Default value is false.
	 * @param b true to show the no color toggle button section, false no.
	 */
    @:dox(hide)
	public function setNoColorSectionVisible(b:Bool):Void{
		if(_noColorSectionVisible != b){
			_noColorSectionVisible = b;
			repaint();
		}
	}
	
	/**
	 * Returns true if the  no color toggle button is shown, otherwise false.
	 * @return true if the  no color toggle button is shown, otherwise false.
	 */
    @:dox(hide)
	public function isNoColorSectionVisible():Bool{
		return _noColorSectionVisible;
	}		
}