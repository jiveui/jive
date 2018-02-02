/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.plaf.basic;

import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.geom.Matrix;

import org.aswing.JPanel;
	import org.aswing.AWSprite;
	import org.aswing.JLabel;
	import org.aswing.JAdjuster;
	import org.aswing.JTextField;
	import org.aswing.Component;
	import org.aswing.BorderLayout;
	import org.aswing.Container;
	import org.aswing.FlowLayout;
	import org.aswing.ASColor;
	import org.aswing.Insets;
	import org.aswing.border.BevelBorder;
import org.aswing.border.EmptyBorder;
import org.aswing.colorchooser.JColorMixer;
import org.aswing.colorchooser.PreviewColorIcon;
import org.aswing.colorchooser.VerticalLayout;
import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.GradientBrush;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.plaf.BaseComponentUI; 
import org.aswing.event.InteractiveEvent;
import org.aswing.event.ReleaseEvent;
import org.aswing.event.AWEvent;
/**
 * @private
 */
class BasicColorMixerUI extends BaseComponentUI {
	
	private var colorMixer:JColorMixer;
	private var mixerPanel:JPanel;
	private var HSMC:AWSprite;
	private var HSPosMC:AWSprite;
	private var LMC:AWSprite;
	private var LPosMC:AWSprite;
	private var previewColorLabel:JLabel;
	private var previewColorIcon:PreviewColorIcon;
	private var AAdjuster:JAdjuster;
	private var RAdjuster:JAdjuster;
	private var GAdjuster:JAdjuster;
	private var BAdjuster:JAdjuster;
	private var HAdjuster:JAdjuster;
	private var SAdjuster:JAdjuster;
	private var LAdjuster:JAdjuster;
	private var hexText:JTextField;
			
	public function new(){
		super();		
	}

    private function getPropertyPrefix():String{
        return "ColorMixer.";
    }
	
    override public function installUI(c:Component):Void{
		colorMixer = AsWingUtils.as(c,JColorMixer);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override public function uninstallUI(c:Component):Void{
		colorMixer = AsWingUtils.as(c,JColorMixer);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
	
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
        LookAndFeel.installColorsAndFont(colorMixer, pp);
		LookAndFeel.installBasicProperties(colorMixer, pp);
        LookAndFeel.installBorderAndBFDecorators(colorMixer, pp);
	}
    private function uninstallDefaults():Void{
    	LookAndFeel.uninstallBorderAndBFDecorators(colorMixer);
    }	
    
	private function installComponents():Void{
		mixerPanel = createMixerPanel();
		previewColorLabel = createPreviewColorLabel();
		previewColorIcon = createPreviewColorIcon();
		previewColorLabel.setIcon(previewColorIcon);
		hexText = createHexTextField();
		createAdjusters();
		layoutComponents();
		createHSAndL();
		updateSectionVisibles();
    }
	private function uninstallComponents():Void{
		colorMixer.removeAll();
    }
        
	private function installListeners():Void{
		colorMixer.addEventListener(InteractiveEvent.STATE_CHANGED, __colorSelectionChanged);
		
		AAdjuster.addActionListener(__AAdjusterValueAction);
		AAdjuster.addStateListener(__AAdjusterValueChanged);
		RAdjuster.addActionListener(__RGBAdjusterValueAction);
		RAdjuster.addStateListener(__RGBAdjusterValueChanged);
		GAdjuster.addActionListener(__RGBAdjusterValueAction);
		GAdjuster.addStateListener(__RGBAdjusterValueChanged);
		BAdjuster.addActionListener(__RGBAdjusterValueAction);
		BAdjuster.addStateListener(__RGBAdjusterValueChanged);
		
		HAdjuster.addActionListener(__HLSAdjusterValueAction);
		HAdjuster.addStateListener(__HLSAdjusterValueChanged);
		LAdjuster.addActionListener(__HLSAdjusterValueAction);
		LAdjuster.addStateListener(__HLSAdjusterValueChanged);
		SAdjuster.addActionListener(__HLSAdjusterValueAction);
		SAdjuster.addStateListener(__HLSAdjusterValueChanged);

		hexText.addActionListener(__hexTextAction);
		hexText.getTextField().addEventListener(Event.CHANGE, __hexTextChanged);
		hexText.getTextField().addEventListener(FocusEvent.FOCUS_OUT, __hexTextAction);
	}
    private function uninstallListeners():Void{
    	colorMixer.removeEventListener(InteractiveEvent.STATE_CHANGED, __colorSelectionChanged);
    }
    
    /**
     * Override this method to change different layout
     */
    private function layoutComponents():Void{
    	colorMixer.setLayout(new BorderLayout(0, 4));
    	
    	var top:Container = SoftBox.createHorizontalBox(4, SoftBoxLayout.CENTER);
    	top.append(mixerPanel);
    	top.append(previewColorLabel);
    	top.setUIElement(true);
    	colorMixer.append(top, BorderLayout.NORTH);
    	
    	var bottom:Container = SoftBox.createHorizontalBox(4, SoftBoxLayout.CENTER);
    	var p:Container = new JPanel(new VerticalLayout(VerticalLayout.RIGHT, 4));
    	p.append(createLabelToComponet(getALabel(), AAdjuster));
    	var cube:Component = new JPanel();
    	cube.setPreferredSize(p.getComponent(0).getPreferredSize());
    	p.append(cube);
    	p.append(createLabelToComponet(getHexLabel(), hexText));
    	bottom.append(p);
    	
    	p = new JPanel(new VerticalLayout(VerticalLayout.RIGHT, 4));
    	p.append(createLabelToComponet(getRLabel(), RAdjuster));
    	p.append(createLabelToComponet(getGLabel(), GAdjuster));
    	p.append(createLabelToComponet(getBLabel(), BAdjuster));
    	bottom.append(p);
    	
    	p = new JPanel(new VerticalLayout(VerticalLayout.RIGHT, 4));
    	p.append(createLabelToComponet(getHLabel(), HAdjuster));
    	p.append(createLabelToComponet(getSLabel(), SAdjuster));
    	p.append(createLabelToComponet(getLLabel(), LAdjuster));
    	bottom.append(p);
    	
    	bottom.setUIElement(true);
    	colorMixer.append(bottom, BorderLayout.SOUTH);
    }
    
    private function createLabelToComponet(label:String, component:Component):Container{
    	var p:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
    	p.append(new JLabel(label));
    	p.append(component);

    	component.addEventListener(AWEvent.HIDDEN, function(?e:Event=null):Void{
    		p.setVisible(false);
    	});
    	component.addEventListener(AWEvent.SHOWN, function(?e:Event=null):Void{
    		p.setVisible(true);
    	});
    	
    	return p;
    }
    //----------------------------------------------------------------------
    
    
    private function getMixerPaneSize():IntDimension{
		var crm:Int= Std.int(getColorRectMargin()*2);
		var hss:IntDimension = getHSSize();
		var ls:IntDimension = getLSize();
		hss.change(crm, crm);
		ls.change(crm, crm);
		var size:IntDimension = new IntDimension(hss.width + getHS2LGap() + ls.width, 
							Std.int(Math.max(hss.height, ls.height)));
		size.change(getMCsMarginSize(), getMCsMarginSize());
		return size;
	}
	
	private function getMCsMarginSize():Int{
		return 4;
	}
	
	private function getColorRectMargin():Int{
		return 1;
	}
    
    private function getHSSize():IntDimension{
    	return new IntDimension(120, 100);
    }
    
    private function getHS2LGap():Int{
    	return 8;
    }
    
    private function getLSize():IntDimension{
    	return new IntDimension(40, 100);
    }
	
	private function getLStripWidth():Int{
		return 20; //half of getLSize().width
	}
	
    private function getSelectedColor():ASColor{
    	var c:ASColor = colorMixer.getSelectedColor();
    	if(c == null) return ASColor.BLACK;
    	return c;
    }
    
    private function setSelectedColor(c:ASColor):Void{
    	color_at_views = c;
    	colorMixer.setSelectedColor(c);
    }
    
    private function updateMixerAllItems():Void{
    	updateMixerAllItemsWithColor(getSelectedColor());
	}	
	
	private function getHFromPos(p:IntPoint):Float{
		return (p.x - getHSColorsStartX()) / getHSSize().width;
	}
	private function getSFromPos(p:IntPoint):Float{
		return 1 - ((p.y - getHSColorsStartY()) / getHSSize().height);
	}
	private function getLFromPos(p:IntPoint):Float{
		return 1 - ((p.y - getLColorsStartY()) / getLSize().height);
	}
	
	private function getHAdjusterValueFromH(h:Float):Float{
		return h * (HAdjuster.getMaximum()- HAdjuster.getMinimum());
	}
	private function getSAdjusterValueFromS(s:Float):Float{
		return s * (SAdjuster.getMaximum()- SAdjuster.getMinimum());
	}
	private function getLAdjusterValueFromL(l:Float):Float{
		return l * (LAdjuster.getMaximum()- LAdjuster.getMinimum());
	}
	
	private function getHFromHAdjuster():Float{
		return HAdjuster.getValue() / (HAdjuster.getMaximum()- HAdjuster.getMinimum());
	}
	private var HAdjusterUpdating:Bool;
	private function updateHAdjusterWithH(h:Float):Void{
		HAdjusterUpdating = true;
		HAdjuster.setValue(Std.int(getHAdjusterValueFromH(h)));
		HAdjusterUpdating = false;
	}
	private function getSFromSAdjuster():Float{
		return SAdjuster.getValue() / (SAdjuster.getMaximum()- SAdjuster.getMinimum());
	}
	private var SAdjusterUpdating:Bool;
	private function updateSAdjusterWithS(s:Float):Void{
		SAdjusterUpdating = true;
		SAdjuster.setValue(Std.int(getSAdjusterValueFromS(s)));
		SAdjusterUpdating = false;
	}
	private function getLFromLAdjuster():Float{
		return LAdjuster.getValue() / (LAdjuster.getMaximum()- LAdjuster.getMinimum());
	}
	private var LAdjusterUpdating:Bool;
	private function updateLAdjusterWithL(l:Float):Void{
		LAdjusterUpdating = true;
		LAdjuster.setValue(Std.int(getLAdjusterValueFromL(l)));
		LAdjusterUpdating = false;
	}
	
	private var RAdjusterUpdating:Bool;
	private function updateRAdjusterWithL(v:Float):Void{
		RAdjusterUpdating = true;
		RAdjuster.setValue(Std.int(v));
		RAdjusterUpdating = false;
	}
	private var GAdjusterUpdating:Bool;
	private function updateGAdjusterWithG(v:Float):Void{
		GAdjusterUpdating = true;
		GAdjuster.setValue(Std.int(v));
		GAdjusterUpdating = false;
	}
	private var BAdjusterUpdating:Bool;
	private function updateBAdjusterWithB(v:Float):Void{
		BAdjusterUpdating = true;
		BAdjuster.setValue(Std.int(v));
		BAdjusterUpdating = false;
	}
	
	private function getAFromAAdjuster():Float{
		return AAdjuster.getValue()/100;
	}
	private var AAdjusterUpdating:Bool;
	private function updateAAdjusterWithA(v:Float):Void{
		AAdjusterUpdating = true;
		AAdjuster.setValue(Std.int(v*100));
		AAdjusterUpdating = false;
	}
	
	private function getColorFromRGBAAdjusters():ASColor{
		var rr:Float= RAdjuster.getValue();
		var gg:Float= GAdjuster.getValue();
		var bb:Float= BAdjuster.getValue();
		return ASColor.getASColor(Std.int(rr), Std.int(gg), Std.int(bb), getAFromAAdjuster());
	}
	private function getColorFromHLSAAdjusters():ASColor{
		var hh:Float= getHFromHAdjuster();
		var ll:Float= getLFromLAdjuster();
		var ss:Float= getSFromSAdjuster();
		return HLSA2ASColor(hh, ll, ss, getAFromAAdjuster());
	}
	//-----------------------------------------------------------------------
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		updateSectionVisibles();
		updateMixerAllItems();
	}
	private function updateSectionVisibles():Void{
		hexText.setVisible(colorMixer.isHexSectionVisible());
		AAdjuster.setVisible(colorMixer.isAlphaSectionVisible());
	}
	//------------------------------------------------------------------------
	private function __AAdjusterValueChanged(e:Event):Void{
		if(AAdjusterUpdating!=true){
			updatePreviewColorWithHSL();
		}
	}
	private function __AAdjusterValueAction(e:Event):Void{
		colorMixer.setSelectedColor(getColorFromMCViewsAndAAdjuster());
	}
	private function __RGBAdjusterValueChanged(e:Event):Void{
		if(RAdjusterUpdating || GAdjusterUpdating || BAdjusterUpdating){
			return;
		}
		var color:ASColor = getColorFromRGBAAdjusters();
		var hls:Dynamic= getHLS(color);
		var hh:Float= hls.h;
		var ss:Float= hls.s;
		var ll:Float= hls.l;
		H_at_HSMC = hh;
		S_at_HSMC = ss;
		L_at_LMC  = ll;
		color_at_views = color;
		updateHSLPosFromHLS(H_at_HSMC, L_at_LMC, S_at_HSMC);
		updateHexTextWithColor(color);
		updateHLSAdjustersWithHLS(hh, ll, ss);
		updatePreviewWithColor(color);
	}
	private function __RGBAdjusterValueAction(e:Event):Void{
		colorMixer.setSelectedColor(getColorFromRGBAAdjusters());
	}
	private function __HLSAdjusterValueChanged(e:Event):Void{
		if(HAdjusterUpdating || LAdjusterUpdating || SAdjusterUpdating){
			return;
		}
		H_at_HSMC = getHFromHAdjuster();
		L_at_LMC  = getLFromLAdjuster();
		S_at_HSMC = getSFromSAdjuster();
		var color:ASColor = HLSA2ASColor(H_at_HSMC, L_at_LMC, S_at_HSMC, getAFromAAdjuster());
		color_at_views = color;
		updateHSLPosFromHLS(H_at_HSMC, L_at_LMC, S_at_HSMC);
		updateHexTextWithColor(color);
		updateRGBAdjustersWithColor(color);
		updatePreviewWithColor(color);
	}
	private function __HLSAdjusterValueAction(e:Event):Void{
		colorMixer.setSelectedColor(getColorFromHLSAAdjusters());
	}
	private function __hexTextChanged(e:Event):Void{
		if(hexTextUpdating)	{
			return;
		}
		var color:ASColor = getColorFromHexTextAndAdjuster();
		var hls:Dynamic= getHLS(color);
		var hh:Float= hls.h;
		var ss:Float= hls.s;
		var ll:Float= hls.l;
		H_at_HSMC = hh;
		S_at_HSMC = ss;
		L_at_LMC  = ll;
		color_at_views = color;
		updateHSLPosFromHLS(H_at_HSMC, L_at_LMC, S_at_HSMC);
		updateHLSAdjustersWithHLS(hh, ll, ss);
		updateRGBAdjustersWithColor(color);
		updatePreviewWithColor(color);
	}
	private function __hexTextAction(e:Event):Void{
		colorMixer.setSelectedColor(getColorFromHexTextAndAdjuster());
	}
	
	private var H_at_HSMC:Float;
	private var S_at_HSMC:Float;
	private var L_at_LMC:Float;
	private var color_at_views:ASColor;
	
	private function __colorSelectionChanged(e:Event):Void{
		var color:ASColor = getSelectedColor();
		previewColorIcon.setColor(color);
		previewColorLabel.repaint();
		if(!color.equals(color_at_views)){
			updateMixerAllItemsWithColor(color);
			color_at_views = color;
		}
	}	
		
	private function createHSAndL():Void{
		HSMC = new AWSprite();
		HSPosMC = new AWSprite();
		LMC = new AWSprite();
		LPosMC = new AWSprite();
		
		mixerPanel.addChild(HSMC);
		mixerPanel.addChild(HSPosMC);
		mixerPanel.addChild(LMC);
		mixerPanel.addChild(LPosMC);

		paintHSMC();
		paintHSPosMC();
		paintLMC();
		paintLPosMC();
		
		HSMC.addEventListener(MouseEvent.MOUSE_DOWN, __HSMCPress);
		HSMC.addEventListener(ReleaseEvent.RELEASE, __HSMCRelease);
		HSMC.addEventListener(ReleaseEvent.RELEASE_OUT_SIDE, __HSMCRelease);
		LMC.addEventListener(MouseEvent.MOUSE_DOWN, __LMCPress);
		LMC.addEventListener(ReleaseEvent.RELEASE, __LMCRelease);
		LMC.addEventListener(ReleaseEvent.RELEASE_OUT_SIDE, __LMCRelease);
	}
	private function __HSMCPress(e:Event):Void{
		HSMC.addEventListener(MouseEvent.MOUSE_MOVE, __HSMCDragging);
		__HSMCDragging(null);
	}
	private function __HSMCRelease(e:Event):Void{
		HSMC.removeEventListener(MouseEvent.MOUSE_MOVE, __HSMCDragging);
		countHSWithMousePosOnHSMCAndUpdateViews();
		setSelectedColor(getColorFromMCViewsAndAAdjuster());
	}
	private function __HSMCDragging(e:Event):Void{
		countHSWithMousePosOnHSMCAndUpdateViews();
	}
	
	private function __LMCPress(e:Event):Void{
		LMC.addEventListener(MouseEvent.MOUSE_MOVE, __LMCDragging);
		__LMCDragging(null);
	}
	private function __LMCRelease(e:Event):Void{
		LMC.removeEventListener(MouseEvent.MOUSE_MOVE, __LMCDragging);		
		countLWithMousePosOnLMCAndUpdateViews();
		setSelectedColor(getColorFromMCViewsAndAAdjuster());
	}
	private function __LMCDragging(e:Event):Void{
		countLWithMousePosOnLMCAndUpdateViews();
	}
	
	private function countHSWithMousePosOnHSMCAndUpdateViews():Void{
		var p:IntPoint = mixerPanel.getMousePosition();
		var hs:Dynamic= getHSWithPosOnHSMC(p);
		HSPosMC.x = p.x;
		HSPosMC.y = p.y;
		var h:Float= hs.h;
		var s:Float= hs.s;
		H_at_HSMC = h;
		S_at_HSMC = s;
		updateOthersWhenHSMCAdjusting();
	}
	private function getHSWithPosOnHSMC(p:IntPoint):Dynamic{
		var hsSize:IntDimension = getHSSize();
		var minX:Float= getHSColorsStartX();
		var maxX:Float= minX + hsSize.width;
		var minY:Float= getHSColorsStartY();
		var maxY:Float= minY + hsSize.height;
		p.x = Std.int(Math.max(minX, Math.min(maxX, p.x)));
		p.y = Std.int(Math.max(minY, Math.min(maxY, p.y)));
		var h:Float= getHFromPos(p);
		var s:Float= getSFromPos(p);
		return {h:h, s:s};
	}
	
	private function countLWithMousePosOnLMCAndUpdateViews():Void{
		var p:IntPoint = mixerPanel.getMousePosition();
		var ll:Float= getLWithPosOnLMC(p);
		LPosMC.y = p.y;
		L_at_LMC = ll;
		updateOthersWhenLMCAdjusting();
	}
	private function getLWithPosOnLMC(p:IntPoint):Float{
		var lSize:IntDimension = getLSize();
		var minY:Float= getLColorsStartY();
		var maxY:Float= minY + lSize.height;
		p.y = Std.int(Math.max(minY, Math.min(maxY, p.y)));
		return getLFromPos(p);
	}
	
	private function getColorFromMCViewsAndAAdjuster():ASColor{
		return HLSA2ASColor(H_at_HSMC, L_at_LMC, S_at_HSMC, getAFromAAdjuster());
	}
	
	private function updatePreviewColorWithHSL():Void{
		updatePreviewWithColor(getColorFromMCViewsAndAAdjuster());
	}
	
	private function updatePreviewWithColor(color:ASColor):Void{
		previewColorIcon.setCurrentColor(color);
		previewColorLabel.repaint();
    	colorMixer.getModel().fireColorAdjusting(color);
	}
	
	private function updateOthersWhenHSMCAdjusting():Void{
		paintLMCWithHS(H_at_HSMC, S_at_HSMC);
		var color:ASColor = getColorFromMCViewsAndAAdjuster();
		updateHexTextWithColor(color);
		updateHLSAdjustersWithHLS(H_at_HSMC, L_at_LMC, S_at_HSMC);
		updateRGBAdjustersWithColor(color);
		updatePreviewWithColor(color);
	}
	
	private function updateOthersWhenLMCAdjusting():Void{
		var color:ASColor = getColorFromMCViewsAndAAdjuster();
		updateHexTextWithColor(color);
		LAdjuster.setValue(Std.int(getLAdjusterValueFromL(L_at_LMC)));
		updateRGBAdjustersWithColor(color);
		updatePreviewWithColor(color);
	}
	    
	//*******************************************************************************
	//       Override these methods to easiy implement different look
	//******************************************************************************
	
	private function getALabel():String{
		return "Alpha:";
	}
	private function getRLabel():String{
		return "R:";
	}
	private function getGLabel():String{
		return "G:";
	}
	private function getBLabel():String{
		return "B:";
	}
	private function getHLabel():String{
		return "H:";
	}
	private function getSLabel():String{
		return "S:";
	}
	private function getLLabel():String{
		return "L:";
	}
	private function getHexLabel():String{
		return "#";
	}
	
	private function updateMixerAllItemsWithColor(color:ASColor):Void{
		var hls:Dynamic= getHLS(color);
		var hh:Float= hls.h;
		var ss:Float= hls.s;
		var ll:Float= hls.l;
		H_at_HSMC = hh;
		S_at_HSMC = ss;
		L_at_LMC  = ll;
		
		updateHSLPosFromHLS(hh, ll, ss);
		
		previewColorIcon.setColor(color);
		previewColorLabel.repaint();
		
		updateRGBAdjustersWithColor(color);
		updateHLSAdjustersWithHLS(hh, ll, ss);
		updateAlphaAdjusterWithColor(color);
		updateHexTextWithColor(color);
	}
	
	private function updateHSLPosFromHLS(hh:Float, ll:Float, ss:Float):Void{
		var hsSize:IntDimension = getHSSize();
		HSPosMC.x = hh*hsSize.width + getHSColorsStartX();
		HSPosMC.y = (1-ss)*hsSize.height + getHSColorsStartY();
		paintLMCWithHS(hh, ss);
		LPosMC.y = getLColorsStartY() + (1-ll)*getLSize().height;
	}
		
	private function updateRGBAdjustersWithColor(color:ASColor):Void{

		updateRAdjusterWithL(color.getRed());
		updateGAdjusterWithG(color.getGreen());
		updateBAdjusterWithB(color.getBlue());
	}
	
	private function updateHLSAdjustersWithHLS(h:Float, l:Float, s:Float):Void{
		updateHAdjusterWithH(h);
		updateLAdjusterWithL(l);
		updateSAdjusterWithS(s);
	}
	
	private function updateAlphaAdjusterWithColor(color:ASColor):Void{
		updateAAdjusterWithA(color.getAlpha());
	}

    private var hexTextColor:ASColor;
    private var hexTextUpdating:Bool;
    private function updateHexTextWithColor(color:ASColor):Void{
    	if(!color.equals(hexTextColor)){
	    	hexTextColor = color;
	    	var hex:String;
	    	if(color == null){
	    		hex = "000000";
	    	}else{
	    		hex = Std.string(color.getRGB());//.toString(16);
	    	}
	    	for(i in 0...6-hex.length){
	    		hex = "0" + hex;
	    	}
	    	hex = hex.toUpperCase();
	    	hexTextUpdating = true;
	    	hexText.setText(hex);
	    	hexTextUpdating = false;
    	}
    }
	
    private function getColorFromHexTextAndAdjuster():ASColor{
    	var text:String= hexText.getText();
    	var rgb:Float= Std.parseFloat("0x" + text);
    	return new ASColor(Std.int(rgb), getAFromAAdjuster());
    }
	
	private function getHSColorsStartX():Float{
		return getMCsMarginSize() + getColorRectMargin();
	}
	private function getHSColorsStartY():Float{
		return getMCsMarginSize() + getColorRectMargin();
	}
	private function getLColorsStartY():Float{
		return getMCsMarginSize() + getColorRectMargin();
	}
	//private function getLColorsStartX():Number{
	//	return getHSSize().width + getMCsMarginSize() + getColorRectMargin()*2 + getHS2LGap();
	//}	
	
	private function paintHSMC():Void{
		HSMC.graphics.clear();
		var g:Graphics2D = new Graphics2D(HSMC.graphics);
		var offset:Float= getMCsMarginSize();
		var thickness:Float= getColorRectMargin();
		var hsSize:IntDimension = getHSSize();
		var H:Int= hsSize.width;
		var S:Int= hsSize.height;
		
		var w:Int= Std.int(H+thickness*2);
		var h:Int =  Std.int(S + thickness * 2);
		//why	
		 
		g.drawLine(new Pen(ASColor.GRAY, thickness), 
					offset+thickness/2, offset+thickness/2, 
					offset+w-thickness, 
					offset+thickness/2);
		g.drawLine(new Pen(ASColor.GRAY, 1), 
					offset+thickness/2, offset+thickness/2, 
					offset+thickness/2, 
					offset+h-thickness);
		 
		offset += thickness;

		var colors:Array<Int>= [0, 0x808080];
		var alphas:Array<Dynamic>= [1, 1];
		var ratios:Array<Dynamic>= [0, 255];
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(1, S, (90/180)*Math.PI, offset, 0); 
		var brush:GradientBrush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		for(x in 0...H){
			var pc:ASColor = HLSA2ASColor(x/H, 0.5, 1, 100);
			colors[0] = pc.getRGB();
			matrix.tx = x+offset;
			g.fillRectangle(brush, x+offset, offset, 1, S);
		}
	}
	
	private function paintHSPosMC():Void{
		HSPosMC.graphics.clear();
		var g:Graphics2D = new Graphics2D(HSPosMC.graphics);
		//why	
		/*
		g.drawLine(new Pen(ASColor.BLACK, 2), -6, 0, -3, 0);
		g.drawLine(new Pen(ASColor.BLACK, 2), 6, 0, 3, 0);
		g.drawLine(new Pen(ASColor.BLACK, 2), 0, -6, 0, -3);
		g.drawLine(new Pen(ASColor.BLACK, 2), 0, 6, 0, 3);
		*/
	}
	private function paintLMCWithHS(hh:Float, ss:Float):Void{
		LMC.graphics.clear();
		var g:Graphics2D = new Graphics2D(LMC.graphics);
		var x:Float= getHSSize().width + getMCsMarginSize() + getColorRectMargin()*2 + getHS2LGap();
		var y:Float= getMCsMarginSize();
		
		var thickness:Float= getColorRectMargin();
		var lSize:IntDimension = getLSize();
		var w:Float= getLStripWidth() + thickness*2;
		var h:Float= lSize.height + thickness*2;
		
		g.drawLine(new Pen(ASColor.GRAY, thickness), 
					x+thickness/2, y+thickness/2, 
					x+w-thickness, 
					y+thickness/2);
		g.drawLine(new Pen(ASColor.GRAY, 1), 
					x+thickness/2, y+thickness/2, 
					x+thickness/2, 
					y+h-thickness);
		x += thickness;
		y += thickness;
		w = getLStripWidth();
		h = lSize.height;

		var colors:Array<Int>= [0xFFFFFF, HLSA2ASColor(hh, 0.5, ss, 100).getRGB(), 0];
		var alphas:Array<Dynamic>= [1, 1, 1];
		var ratios:Array<Dynamic>= [0, 127.5, 255];
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(w, h, (90/180)*Math.PI, x, y); 
		var brush:GradientBrush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		g.fillRectangle(brush, x, y, w, h);		
	}
	private function paintLMCWithColor(color:ASColor):Void{
		var hls:Dynamic= getHLS(color);
		var hh:Float= hls.h;
		var ss:Float= hls.s;
		paintLMCWithHS(hh, ss);
	}
	private function paintLMC():Void{
		paintLMCWithColor(getSelectedColor());
	}
	private function paintLPosMC():Void{
		LPosMC.graphics.clear();
		var g:Graphics2D = new Graphics2D(LPosMC.graphics);
		g.fillPolygon(new SolidBrush(ASColor.BLACK), [
		new IntPoint(0, 0), new IntPoint(4, -4), new IntPoint(4, 4)]);
		LPosMC.x = getHSSize().width + getMCsMarginSize() + getColorRectMargin()*2 
					+ getHS2LGap() + getLStripWidth() + 1;
	}
	
	private function createMixerPanel():JPanel{
		var p:JPanel = new JPanel();
		p.setBorder(null); //esure there is no border
		p.setPreferredSize(getMixerPaneSize());
		return p;
	}
	
	private function createPreviewColorIcon():PreviewColorIcon{
		return new PreviewColorIcon(46, 100, PreviewColorIcon.VERTICAL);
	}
	
	private function createPreviewColorLabel():JLabel{
		var label:JLabel = new JLabel();
		var margin:Float= getMCsMarginSize();
		var bb:BevelBorder = new BevelBorder(null, BevelBorder.LOWERED);
		bb.setThickness(1);
		label.setBorder(new EmptyBorder(bb, new Insets(Std.int(margin), 0, Std.int(margin), 0))); 
		return label;
	}
	
	private function createHexTextField():JTextField{
		return new JTextField("000000", 6);
	}
	
	private function createAdjusters():Void{
		AAdjuster = createAAdjuster();
		RAdjuster = createRAdjuster();
		GAdjuster = createGAdjuster();
		BAdjuster = createBAdjuster();
		HAdjuster = createHAdjuster();
		SAdjuster = createSAdjuster();
		LAdjuster = createLAdjuster();
	}
	
	private function createAAdjuster():JAdjuster{
		var adjuster:JAdjuster = new JAdjuster(4, JAdjuster.VERTICAL);		
		adjuster.setValueTranslator(
			function(value:Float):String{
				return Math.round(value) + "%";
			});
		adjuster.setValues(100, 0, 0, 100);
		return adjuster;
	}
	private function createRAdjuster():JAdjuster{
		var adjuster:JAdjuster = new JAdjuster(4, JAdjuster.VERTICAL);
		adjuster.setValues(255, 0, 0, 255);
		return adjuster;
	}
	private function createGAdjuster():JAdjuster{
		var adjuster:JAdjuster = new JAdjuster(4, JAdjuster.VERTICAL);
		adjuster.setValues(255, 0, 0, 255);
		return adjuster;
	}
	private function createBAdjuster():JAdjuster{
		var adjuster:JAdjuster = new JAdjuster(4, JAdjuster.VERTICAL);
		adjuster.setValues(255, 0, 0, 255);
		return adjuster;
	}
	private function createHAdjuster():JAdjuster{
		var adjuster:JAdjuster = new JAdjuster(4, JAdjuster.VERTICAL);
		adjuster.setValues(0, 0, 0, 360);
		adjuster.setValueTranslator(
			function(value:Float):String{
				return Math.round(value) + "°";
			});
		return adjuster;
	}
	private function createSAdjuster():JAdjuster{
		var adjuster:JAdjuster = new JAdjuster(4, JAdjuster.VERTICAL);
		adjuster.setValues(0, 0, 0, 100);
		adjuster.setValueTranslator(
			function(value:Float):String{
				return Math.round(value) + "%";
			});
		return adjuster;
	}
	private function createLAdjuster():JAdjuster{
		var adjuster:JAdjuster = new JAdjuster(4, JAdjuster.VERTICAL);
		adjuster.setValues(0, 0, 0, 100);
		adjuster.setValueTranslator(
			function(value:Float):String{
				return Math.round(value) + "%";
			});
		return adjuster;
	}
	
	//----------------Tool functions--------------------
	
	private static function getHLS(color:ASColor):Dynamic{
		var rr:Float= color.getRed()/255;
		var gg:Float= color.getGreen()/255;
		var bb:Float= color.getBlue()/255;
		var hls:Dynamic= rgb2Hls(rr, gg, bb);
		return hls;
	}
	
	/**
	 * H, L, S -> [0, 1], alpha -> [0, 100]
	 */
	private static function HLSA2ASColor(H:Float, L:Float, S:Float, alpha:Float):ASColor{
		var p1:Float, p2:Float, r:Float, g:Float, b:Float;
		p1 = p2 = 0;
		H = H*360;
		if(L<0.5){
			p2=L*(1+S);
		}else{
			p2=L + S - L*S;
		}
		p1=2*L-p2;
		if(S==0){
			r=L;
			g=L;
			b=L;
		}else{
			r = hlsValue(p1, p2, H+120);
			g = hlsValue(p1, p2, H);
			b = hlsValue(p1, p2, H-120);
		}
		r *= 255;
		g *= 255;
		b *= 255;
		return ASColor.getASColor(Std.int(r), Std.int(g), Std.int(b), alpha);
	}
	
	private static function hlsValue(p1:Float, p2:Float, h:Float):Float{
	   if (h > 360) h = h - 360;
	   if (h < 0)   h = h + 360;
	   if (h < 60 ) return p1 + (p2-p1)*h/60;
	   if (h < 180) return p2;
	   if (h < 240) return p1 + (p2-p1)*(240-h)/60;
	   return p1;
	}
	
	private static function rgb2Hls(rr:Float, gg:Float, bb:Float):Dynamic{
	   // Static method to compute HLS from RGB. The r,g,b triplet is between
	   // [0,1], h, l, s are [0,1].
	
		var rnorm:Float, gnorm:Float, bnorm:Float;
		var minval:Float, maxval:Float, msum:Float, mdiff:Float;
		var r:Float, g:Float, b:Float;
	   	var hue:Float, light:Float, satur:Float;
	   	
		r = g = b = 0;
		if (rr > 0) r = rr; if (r > 1) r = 1;
		if (gg > 0) g = gg; if (g > 1) g = 1;
		if (bb > 0) b = bb; if (b > 1) b = 1;
		
		minval = r;
		if (g < minval) minval = g;
		if (b < minval) minval = b;
		maxval = r;
		if (g > maxval) maxval = g;
		if (b > maxval) maxval = b;
		
		rnorm = gnorm = bnorm = 0;
		mdiff = maxval - minval;
		msum  = maxval + minval;
		light = 0.5 * msum;
		if (maxval != minval) {
			rnorm = (maxval - r)/mdiff;
			gnorm = (maxval - g)/mdiff;
			bnorm = (maxval - b)/mdiff;
		} else {
			satur = hue = 0;
			return {h:hue, l:light, s:satur};
		}
		
		if (light < 0.5)
		  satur = mdiff/msum;
		else
		  satur = mdiff/(2.0 - msum);
		
		if (r == maxval)
		  hue = 60.0 * (6.0 + bnorm - gnorm);
		else if (g == maxval)
		  hue = 60.0 * (2.0 + rnorm - bnorm);
		else
		  hue = 60.0 * (4.0 + gnorm - rnorm);
		
		if (hue > 360)
			hue = hue - 360;
		hue/=360;
		return {h:hue, l:light, s:satur};
	}	
}