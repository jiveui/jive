/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.plaf.basic;


import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent; 
import flash.text.TextField;
 

import org.aswing.JLabel;
	import org.aswing.JTextField;
	import org.aswing.JAdjuster;
	import org.aswing.AbstractButton;
	import org.aswing.JPanel;
	import org.aswing.Container;
	import org.aswing.AWSprite;
	import org.aswing.Component;
	import org.aswing.BorderLayout;
	import org.aswing.ASColor;
	import org.aswing.JButton;
	import org.aswing.border.BevelBorder;
import org.aswing.colorchooser.JColorSwatches;
	import org.aswing.colorchooser.ColorRectIcon;
	import org.aswing.colorchooser.NoColorIcon;
	import org.aswing.event.AWEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.event.DragAndDropEvent;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.plaf.BaseComponentUI;
	import org.aswing.plaf.ColorSwatchesUI;
	/**
 * @private
 */
class BasicColorSwatchesUI extends BaseComponentUI  implements ColorSwatchesUI{
	
	private var colorSwatches:JColorSwatches;
	private var selectedColorLabel:JLabel;
	private var selectedColorIcon:ColorRectIcon;
	private var colorHexText:JTextField;
	private var alphaAdjuster:JAdjuster;
	private var noColorButton:AbstractButton;
	private var colorTilesPane:JPanel;
	private var topBar:Container;
	private var barLeft:Container;
	private var barRight:Container;
	private var selectionRectMC:AWSprite;
	
	public function new(){
		super();		
	}
    
    private function getPropertyPrefix():String{
    	return "ColorSwatches.";
    }

    override public function installUI(c:Component):Void{
		colorSwatches = AsWingUtils.as(c,JColorSwatches);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override public function uninstallUI(c:Component):Void{
		colorSwatches = AsWingUtils.as(c,JColorSwatches);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
	
	private function installDefaults():Void{
		var pp:String= getPropertyPrefix();
        LookAndFeel.installColorsAndFont(colorSwatches, pp);
		LookAndFeel.installBasicProperties(colorSwatches, pp);
        LookAndFeel.installBorderAndBFDecorators(colorSwatches, pp);
	}
    private function uninstallDefaults():Void{
    	LookAndFeel.uninstallBorderAndBFDecorators(colorSwatches);
    }	
    
	private function installComponents():Void{
		selectedColorLabel = createSelectedColorLabel();
		selectedColorIcon = createSelectedColorIcon();
		selectedColorLabel.setIcon(selectedColorIcon);
		
		colorHexText = createHexText();
		alphaAdjuster = createAlphaAdjuster();
		noColorButton = createNoColorButton();
		colorTilesPane = createColorTilesPane();
		
		topBar = new JPanel(new BorderLayout());
		barLeft = SoftBox.createHorizontalBox(2, SoftBoxLayout.LEFT);
		barRight = SoftBox.createHorizontalBox(2, SoftBoxLayout.RIGHT);
		topBar.append(barLeft, BorderLayout.WEST);
		topBar.append(barRight, BorderLayout.EAST);
		
		barLeft.append(selectedColorLabel);
		barLeft.append(colorHexText);
		barRight.append(alphaAdjuster);
		barRight.append(noColorButton);
		
		topBar.setUIElement(true);
		colorTilesPane.setUIElement(true);
		
		colorSwatches.setLayout(new BorderLayout(4, 4));
		colorSwatches.append(topBar, BorderLayout.NORTH);
		colorSwatches.append(colorTilesPane, BorderLayout.CENTER);
		createTitles();
		updateSectionVisibles();
    }
	private function uninstallComponents():Void{
		colorSwatches.remove(topBar);
		colorSwatches.remove(colorTilesPane);
    }
        
	private function installListeners():Void{
		noColorButton.addActionListener(__noColorButtonAction);

		colorSwatches.addEventListener(InteractiveEvent.STATE_CHANGED, __colorSelectionChanged);
		colorSwatches.addEventListener(AWEvent.HIDDEN, __colorSwatchesUnShown);
		
		colorTilesPane.addEventListener(MouseEvent.ROLL_OVER, __colorTilesPaneRollOver);
		colorTilesPane.addEventListener(MouseEvent.ROLL_OUT, __colorTilesPaneRollOut);
		colorTilesPane.addEventListener(DragAndDropEvent.DRAG_EXIT, __colorTilesPaneRollOut);
		colorTilesPane.addEventListener(MouseEvent.MOUSE_UP, __colorTilesPaneReleased);
		
		colorHexText.addActionListener(__hexTextAction);
		colorHexText.getTextField().addEventListener(Event.CHANGE, __hexTextChanged);
		
		alphaAdjuster.addStateListener(__adjusterValueChanged);
		alphaAdjuster.addActionListener(__adjusterAction);
	}
    private function uninstallListeners():Void{
    	noColorButton.removeActionListener(__noColorButtonAction);
    	
    	colorSwatches.removeEventListener(InteractiveEvent.STATE_CHANGED, __colorSelectionChanged);
    	colorSwatches.removeEventListener(AWEvent.HIDDEN, __colorSwatchesUnShown);
    	colorSwatches.removeEventListener(MouseEvent.MOUSE_MOVE, __colorTilesPaneMouseMove); 
    	
		colorTilesPane.removeEventListener(MouseEvent.ROLL_OVER, __colorTilesPaneRollOver);
		colorTilesPane.removeEventListener(MouseEvent.ROLL_OUT, __colorTilesPaneRollOut);
		colorTilesPane.removeEventListener(DragAndDropEvent.DRAG_EXIT, __colorTilesPaneRollOut);
		colorTilesPane.removeEventListener(MouseEvent.MOUSE_UP, __colorTilesPaneReleased);   
		
		colorHexText.removeActionListener(__hexTextAction);
		colorHexText.getTextField().removeEventListener(Event.CHANGE, __hexTextChanged);	
		
		alphaAdjuster.removeStateListener(__adjusterValueChanged);
		alphaAdjuster.removeActionListener(__adjusterAction);		
    }
    
    //------------------------------------------------------------------------------
    private function __adjusterValueChanged(e:Event):Void{
		updateSelectedColorLabelColor(getColorFromHexTextAndAdjuster());
    }
    private function __adjusterAction(e:Event):Void{
    	colorSwatches.setSelectedColor(getColorFromHexTextAndAdjuster());
    }
    
    private function __hexTextChanged(e:Event):Void{
		updateSelectedColorLabelColor(getColorFromHexTextAndAdjuster());
    }
    private function __hexTextAction(e:Event):Void{
    	colorSwatches.setSelectedColor(getColorFromHexTextAndAdjuster());
    }
    
    private function __colorTilesPaneRollOver(e:Event):Void{
    	colorSwatches.removeEventListener(MouseEvent.MOUSE_MOVE, __colorTilesPaneMouseMove);
    	colorSwatches.addEventListener(MouseEvent.MOUSE_MOVE, __colorTilesPaneMouseMove);
    	
    }
    private function __colorTilesPaneRollOut(e:Event):Void{
    	stopMouseMovingSelection();
    }
    private var lastOutMoving:Bool;
    private function __colorTilesPaneMouseMove(e:Event):Void{
    	var p:IntPoint = colorTilesPane.getMousePosition();
    	var color:ASColor = getColorWithPosAtColorTilesPane(p);
    	if(color != null){
    		var sp:IntPoint = getSelectionRectPos(p);
    		selectionRectMC.visible = true;
    		selectionRectMC.x = sp.x;
    		selectionRectMC.y = sp.y;
			updateSelectedColorLabelColor(color);
			fillHexTextWithColor(color);
    		lastOutMoving = false;
    		//updateAfterEvent();
    	}else{
    		color = colorSwatches.getSelectedColor();
    		selectionRectMC.visible = false;
    		if(lastOutMoving != true){
				updateSelectedColorLabelColor(color);
				fillHexTextWithColor(color);
    		}
    		lastOutMoving = true;
    	}
    }
    private function __colorTilesPaneReleased(e:MouseEvent):Void{
    	var p:IntPoint = new IntPoint(Std.int(e.localX), Std.int(e.localY));//colorTilesPane.getMousePosition();
    	var color:ASColor = getColorWithPosAtColorTilesPane(p);
    	if(color != null){
    		colorSwatches.setSelectedColor(color);
    	}
    }
    
    private function __noColorButtonAction(e:AWEvent):Void{
    	colorSwatches.setSelectedColor(null);
    }
    
    private var colorTilesMC:AWSprite;
	private function createTitles():Void{
		colorTilesMC = new AWSprite();
		selectionRectMC = new AWSprite();
		colorTilesPane.addChild(colorTilesMC);
		colorTilesPane.addChild(selectionRectMC);
		paintColorTiles();
		paintSelectionRect();
		selectionRectMC.visible = false;
	}
	
	private function __colorSelectionChanged(e:Event):Void{
		var color:ASColor = colorSwatches.getSelectedColor();
		fillHexTextWithColor(color);
		fillAlphaAdjusterWithColor(color);
		updateSelectedColorLabelColor(color);
	}
	private function __colorSwatchesUnShown(e:Event):Void{
		stopMouseMovingSelection();
	}
	private function stopMouseMovingSelection():Void{
		colorSwatches.removeEventListener(MouseEvent.MOUSE_MOVE, __colorTilesPaneMouseMove);
		selectionRectMC.visible = false;
		var color:ASColor = colorSwatches.getSelectedColor();
		updateSelectedColorLabelColor(color);
		fillHexTextWithColor(color);
	}
	
	//-----------------------------------------------------------------------
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
		super.paint(c, g, b);
		updateSectionVisibles();
		updateSelectedColorLabelColor(colorSwatches.getSelectedColor());
		fillHexTextWithColor(colorSwatches.getSelectedColor());
	}
	private function updateSectionVisibles():Void{
		colorHexText.setVisible(colorSwatches.isHexSectionVisible());
		alphaAdjuster.setVisible(colorSwatches.isAlphaSectionVisible());
		noColorButton.setVisible(colorSwatches.isNoColorSectionVisible());
	}
    
	//*******************************************************************************
	//      Data caculating methods
	//******************************************************************************
    private function getColorFromHexTextAndAdjuster():ASColor{
    	var text:String= colorHexText.getText();
    	if(text.charAt(0) == "#"){
    		text = text.substr(1);
    	}
    	var rgb:Float= Std.parseFloat("0x" + text);
    	return new ASColor(Std.int(rgb), alphaAdjuster.getValue()/100);
    }
    private var hexTextColor:ASColor;
    private function fillHexTextWithColor(color:ASColor):Void{
    	if (color == null){
    		 hexTextColor = color;
	    	colorHexText.setText("#000000");
    	}else if(!color.equals(hexTextColor)){
	    	hexTextColor = color;
	    	var hex:String;
	    	hex = Std.string(color.getRGB());
			
	    	for(i in 0...6-hex.length ){
	    		hex = "0" + hex;
	    	}
	    	hex = "#" + hex.toUpperCase();
	    	colorHexText.setText(hex);
    	}
    }
    private function fillAlphaAdjusterWithColor(color:ASColor):Void{
    	var alpha:Float= (color == null ? 100 : color.getAlpha());
		alphaAdjuster.setValue(Std.int(alpha*100));
    }
    
    private function isEqualsToSelectedIconColor(color:ASColor):Bool{
		if(color == null){
			return selectedColorIcon.getColor() == null;
		}else{
			return color.equals(selectedColorIcon.getColor());
		}
	}
    private function updateSelectedColorLabelColor(color:ASColor):Void{
    	if(!isEqualsToSelectedIconColor(color)){
	    	selectedColorIcon.setColor(color);
	    	selectedColorLabel.repaint();
	    	colorSwatches.getModel().fireColorAdjusting(color);
    	}
    }
    private function getSelectionRectPos(p:IntPoint):IntPoint{
    	var L:Float= getTileL();
    	return new IntPoint(Std.int(Math.floor(p.x/L)*L), Std.int(Math.floor(p.y/L)*L));
    }
    //if null returned means not in color tiles bounds
    private function getColorWithPosAtColorTilesPane(p:IntPoint):ASColor{
    	var L:Float= getTileL();
    	var size:IntDimension = getColorTilesPaneSize();
    	if(p.x < 0 || p.y < 0 || p.x >= size.width || p.y >= size.height){
    		return null;
    	}
    	var alpha:Float= alphaAdjuster.getValue()/100;
    	if(p.x < L){
    		var index:Float= Math.floor(p.y/L);
    		index = Math.max(0, Math.min(11, index));
    		return new ASColor(getLeftColumColors()[Std.int(index)], alpha);
    	}
    	if(p.x < L*2){
    		return new ASColor(0x000000, alpha);
    	}
    	var x:Float= p.x - L*2;
    	var y:Float= p.y;
    	var bigTile:Float= (L*6);
    	var tx:Float= Math.floor(x/bigTile);
    	var ty:Float= Math.floor(y/bigTile);
    	var ti:Float= ty*3 + tx;
    	var xi:Float= Math.floor((x - tx*bigTile)/L);
    	var yi:Float= Math.floor((y - ty*bigTile)/L);
    	return getTileColorByTXY(ti, xi, yi, alpha);
    }
    private function getLeftColumColors():Array<Dynamic>{
    	return [0x000000, 0x333333, 0x666666, 0x999999, 0xCCCCCC, 0xFFFFFF, 
							  0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0x00FFFF, 0xFF00FF];
    }
    private function getTileColorByTXY(t:Float, x:Float, y:Float, alpha:Float=1):ASColor{
		var rr:Float= 0x33*t;
		var gg:Float= 0x33*x;
		var bb:Float= 0x33*y;
		var c:ASColor = ASColor.getASColor(Std.int(rr), Std.int(gg), Std.int(bb), alpha);
		return c;
    }
	private function paintColorTiles():Void{
		var g:Graphics2D = new Graphics2D(colorTilesMC.graphics);	
		var startX:Float= 0;
		var startY:Float= 0;
		var L:Float= getTileL();
		var leftLine:Array<Dynamic>= getLeftColumColors();
		for(y in 0...6*2){
			fillRect(g, startX, startY+y*L, new ASColor(leftLine[y]));
		}
		startX += L;
		for(y2 in 0...6*2){
			fillRect(g, startX, startY+y2*L, ASColor.BLACK);
		}
		startX += L;		
		
		for(t in 0...6){
			for(x in 0...6){
				for(y3 in 0...6){
					var c:ASColor = getTileColorByTXY(t, x, y3);
					fillRect(g, 
							 startX + (t%3)*(6*L) + x*L, 
							 startY + Math.floor(t/3)*(6*L) + y3*L, 
							 c);
				}
			}
		}
	}
	private function paintSelectionRect():Void{
		var g:Graphics2D = new Graphics2D(selectionRectMC.graphics);
		//why	
		 
		g.drawRectangle(new Pen(ASColor.WHITE, 0), 0, 0, getTileL(), getTileL());
		 
	}
	
	private function fillRect(g:Graphics2D, x:Float, y:Float, c:ASColor):Void{
		g.beginDraw(new Pen(ASColor.BLACK, 0));
		g.beginFill(new SolidBrush(c));
		g.rectangle(x, y, getTileL(), getTileL());
		g.endFill();
		g.endDraw();
	}
	private function getColorTilesPaneSize():IntDimension{
		return new IntDimension(Std.int((3*6+2)*getTileL()), Std.int((2*6)*getTileL()));
	}
	
	private function getTileL():Float{
		return 12;
	}
    
	//*******************************************************************************
	//              Override these methods to easiy implement different look
	//******************************************************************************
	public function addComponentColorSectionBar(com:Component):Void{
		barRight.append(com);
	}	
	
	private function createSelectedColorLabel():JLabel{
		var label:JLabel = new JLabel();
		var bb:BevelBorder = new BevelBorder(null, BevelBorder.LOWERED);
		bb.setThickness(1);
		label.setBorder(bb); 
		return label;
	}
	
	private function createSelectedColorIcon():ColorRectIcon{
		return new ColorRectIcon(38, 18, colorSwatches.getSelectedColor());
	}
	
	private function createHexText():JTextField{
		return new JTextField("#FFFFFF", 6);
	}
	
	private function createAlphaAdjuster():JAdjuster{
		var adjuster:JAdjuster = new JAdjuster(4, JAdjuster.VERTICAL);
		adjuster.setValueTranslator(
			function(value:Float):String{
				return Math.round(value) + "%";
			});
		adjuster.setValues(100, 0, 0, 100);
		return adjuster;
	}
	private function createNoColorButton():AbstractButton{
		return new JButton("", new NoColorIcon(16, 16));
	}
	private function createColorTilesPane():JPanel{
		var p:JPanel = new JPanel();
		p.setBorder(null); //ensure there is no border there
    	var size:IntDimension = getColorTilesPaneSize();
    	size.change(1, 1);
		p.setPreferredSize(size);
		p.mouseChildren = false;
		return p;
	}
}
