package org.aswing.plaf.basic.frame;


import flash.display.DisplayObject;
import flash.geom.Matrix;

import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.FrameTitleBar;
import org.aswing.GroundDecorator;
import org.aswing.UIManager;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.Pen;
import org.aswing.plaf.FrameUI;
import org.aswing.plaf.UIResource;

class BasicFrameTitleBarBG implements GroundDecorator implements UIResource{
		
	private var activeColor:ASColor;
	private var inactiveColor:ASColor;
	private var activeBorderColor:ASColor;
	
	public function new(){
		 
	}

	public function getDisplay(c:Component):DisplayObject{
		return null;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		 
		var bar:FrameTitleBar = AsWingUtils.as(c,FrameTitleBar);
		var frameUI:FrameUI = AsWingUtils.as(bar.getFrame().getUI() , FrameUI);
		if(activeColor == null){
			var activeColor:ASColor;
			var inactiveColor:ASColor;
			if(frameUI!=null)	{
				activeColor = frameUI.getColor("Frame.activeCaption");
				inactiveColor = frameUI.getColor("Frame.inactiveCaption");
				activeBorderColor = frameUI.getColor("Frame.activeCaptionBorder");
			}else{
				activeColor = UIManager.getColor("Frame.activeCaption");
				inactiveColor = UIManager.getColor("Frame.inactiveCaption");
				activeBorderColor = UIManager.getColor("Frame.activeCaptionBorder");
			}
		}
        var x:Float= b.x;
		var y:Float= b.y;
		var w:Float= b.width;
		var h:Float= b.height;
		
		var colors:Array<Int>;
		if(frameUI == null || frameUI.isPaintActivedFrame()){
	    	colors = [activeColor.darker(0.9).getRGB(), activeColor.getRGB()];
		}else{
	    	colors = [inactiveColor.darker(0.9).getRGB(), inactiveColor.getRGB()];
		}
		var alphas:Array<Dynamic>= [1, 1];
		var ratios:Array<Dynamic>= [75, 255];
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(w, h, (90/180)*Math.PI, x, y);
	    var brush:GradientBrush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
	    g.fillRoundRect(brush, x, y, w, h, 4, 4, 0, 0);    
		
		if(frameUI == null || frameUI.isPaintActivedFrame()){
			colors = [activeColor.getRGB(), activeColor.getRGB()];
		}else{
			colors = [inactiveColor.getRGB(), inactiveColor.getRGB()];
		}
        
		alphas = [1, 0];
		ratios = [0, 100];
        brush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
		
        g.fillRoundRect(brush, x, y, w, h - h / 4, 4, 4, 0, 0);
		//why	
		 
        var penTool:Pen = new Pen(activeBorderColor);
        g.drawLine(penTool, x, y+h-1, x+w, y+h-1);	
		 
	}
	
}