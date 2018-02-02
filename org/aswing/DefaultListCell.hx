/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.event.ResizedEvent;
	import org.aswing.geom.IntPoint;

/**
 * Default list cell, render item value.toString() text.
 * @author paling
 */
class DefaultListCell extends AbstractListCell{
	
	private var jlabel:JLabel;
			
	private static var sharedToolTip:JSharedToolTip;
	
	public function new(){
		super();
		if(sharedToolTip == null){
			sharedToolTip = JSharedToolTip.getSharedInstance();
			sharedToolTip.setOffsetsRelatedToMouse(false);
			sharedToolTip.setOffsets(new IntPoint(0, 0));
		}
	}
	
	override public function setCellValue(value:Dynamic) : Void{
		super.setCellValue(value);
		getJLabel().setText(getStringValue(value));
		__resized(null);
	}
	
	/**
	 * Override this if you need other value->string translator
	 */
	private function getStringValue(value:Dynamic):String{
		return value + "";
	}
	
	override public function getCellComponent() : Component {
		return getJLabel();
	}

	private function getJLabel():JLabel{
		if(jlabel == null){
			jlabel = new JLabel();
			initJLabel(jlabel);
		}
		return jlabel;
	}
	
	private function initJLabel(jlabel:JLabel):Void{
		jlabel.setHorizontalAlignment(JLabel.LEFT);
		jlabel.setOpaque(true);
		jlabel.setFocusable(false);
		jlabel.addEventListener(ResizedEvent.RESIZED, __resized);
	 
	}
	
	private function __resized(e:ResizedEvent):Void { 
		if(getJLabel().getWidth() < getJLabel().getPreferredWidth()){
			getJLabel().setToolTipText(value.toString());
		 
			sharedToolTip.registerComponent(getJLabel());
		}else{
			getJLabel().setToolTipText(null);
			sharedToolTip.unregisterComponent(getJLabel());
		}
	}
}