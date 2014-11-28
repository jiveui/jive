/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;


import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.geom.Matrix;
import flash.geom.Point;

import org.aswing.StyleResult;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.AbstractButton;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.GradientBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.graphics.Pen;
	/**
 * @private
 */
class BasicGraphicsUtils{
	
	public static var gradientRatio:Array<Dynamic> = [0, 255];
	public static var roundRectBtmFix:Float= 0.5;
	
	/**
	 * Returns the gradient brush with tune
	 * @param tune the tune
	 * @param matrix the matrix
	 * @param border true means for border, false means for content
	 */
	public static function getGradientBrush(tune:StyleResult, matrix:Matrix, border:Bool=false, ratios:Array<Dynamic>=null):GradientBrush{
		var light:ASColor;
		var dark:ASColor;
		if(border)	{
			light = tune.blight;
			dark  = tune.bdark;
		}else{
			light = tune.clight;
			dark  = tune.cdark;
		}
		if(ratios == null){
			ratios = gradientRatio;
		}
		return new GradientBrush(
			GradientBrush.LINEAR, 
			[light.getRGB(), dark.getRGB()], 
			[light.getAlpha(), dark.getAlpha()], 
			ratios, 
			matrix
			);
	}
	
	public static function drawRoundRect(g:Graphics2D, x:Float, y:Float, w:Float, h:Float, r:Float):Void{
		var fix:Float= r > 5 ? 0 : roundRectBtmFix;
		g.roundRect(x, y, w, h, r, r, r+fix, r+fix);
	}
	
	private static var sharedMatrix:Matrix = new Matrix();
	/**
	 * Fill gradient round rectangle, if tune.round < roundRectBtmFix, it will fill rectangle with no round
	 */
	public static function fillGradientRoundRect(g:Graphics2D, b:IntRectangle, tune:StyleResult, direction:Float=1.5707963267948966, border:Bool=false, matrixB:IntRectangle=null, ratios:Array<Dynamic>=null):Void{
		if(matrixB == null){
			matrixB = b;
		}
		sharedMatrix.createGradientBox(matrixB.width, matrixB.height, direction, matrixB.x, matrixB.y);
		g.beginFill(getGradientBrush(tune, sharedMatrix, border, ratios));
		var r:Float= tune.round;
		if(r < roundRectBtmFix){
			g.rectangle(b.x, b.y, b.width, b.height);
		}else{
			var fix:Float= roundRectBtmFix;
			if(r > 5){
				fix = 0;
			}
			g.roundRect(b.x, b.y, b.width, b.height, r, r, r+fix, r+fix);
		}
		g.endFill();
	}

    public static function fillGradientCircle(g:Graphics2D, b:IntRectangle, tune:StyleResult, direction:Float=1.5707963267948966):Void{
        var matrixB = b;
        sharedMatrix.createGradientBox(matrixB.width, matrixB.height, direction, matrixB.x, matrixB.y);
        g.beginFill(getGradientBrush(tune, sharedMatrix, false, null));
        drawCircle(g, b);
        g.endFill();
    }

    public static function drawCircle(g:Graphics2D, b:IntRectangle):Void{
        g.circle(b.x + b.width/2, b.y + b.height/2, Math.floor(Math.min(b.width, b.height)/2) - 1);
    }

	public static function fillGradientRoundRectBottomRightAngle(g:Graphics2D, b:IntRectangle, tune:StyleResult, direction:Float=1.5707963267948966, border:Bool=false, matrixB:IntRectangle=null):Void{
		if(matrixB == null){
			matrixB = b;
		}
		sharedMatrix.createGradientBox(matrixB.width, matrixB.height, direction, matrixB.x, matrixB.y);
		g.beginFill(getGradientBrush(tune, sharedMatrix, border));
		var r:Float= tune.round;
		if(r < roundRectBtmFix){
			g.rectangle(b.x, b.y, b.width, b.height);
		}else{
			var fix:Float= roundRectBtmFix;
			if(r > 5){
				fix = 0;
			}
			g.roundRect(b.x, b.y, b.width, b.height, r, r, 0, 0);
		}
		g.endFill();
	}	
	
	/**
	 * Call draw path gradient round rectangle, if r < roundRectBtmFix, it will fill rectangle with no round
	 */	
	public static function drawRoundRectLine(g:Graphics2D, x:Float, y:Float, w:Float, h:Float, r:Float, t:Float):Void{
		if(r < roundRectBtmFix){
			g.rectangle(x, y, w, h);
			g.rectangle(x+t, y+t, w-t*2, h-t*2);
		}else{
			var fix:Float= roundRectBtmFix;
			if(r > 5){
				fix = 0;
			}
			g.roundRect(x, y, w, h, r, r, r+fix, r+fix);
			r -= t/2;
			g.roundRect(x+t, y+t, w-t*2, h-t*2, r, r, r+fix, r+fix);
		}
	}
	
	/**
	 * Fill gradient round rectangle line, if tune.round < roundRectBtmFix, it will fill rectangle line with no round
	 */	
	public static function drawGradientRoundRectLine(g:Graphics2D, b:IntRectangle, t:Float, tune:StyleResult, direction:Float=1.5707963267948966, border:Bool=true, matrixB:IntRectangle=null):Void{
		var w:Float= b.width;
		var h:Float= b.height;
		var x:Float= b.x;
		var y:Float= b.y;
		var r:Float= tune.round;
		if(matrixB == null){
			matrixB = b;
		}
		sharedMatrix.createGradientBox(matrixB.width, matrixB.height, direction, matrixB.x, matrixB.y);
		g.beginFill(getGradientBrush(tune, sharedMatrix, border));
		drawRoundRectLine(g, b.x, b.y, b.width, b.height, r, t);
		g.endFill();
	}
	
	public static function getArrowPath(width:Float, direction:Float, centerX:Float, centerY:Float, round:Bool=true):Array<Dynamic>{
		var center:Point = new Point(centerX, centerY);
		var w:Float= width;
		var ps1:Array<Dynamic>= new Array<Dynamic>();
		ps1.push(nextPoint(center, direction, w/2/2, round));
		var back:Point = nextPoint(center, direction + Math.PI, w/2/2);
		ps1.push(nextPoint(back, direction - Math.PI/2, w/2, round));
		ps1.push(nextPoint(back, direction + Math.PI/2, w/2, round));
		return ps1;
	}
	
	private static function nextPoint(p:Point, dir:Float, dis:Float, round:Bool=false):Point{
		if(round)	{
			return new Point(Math.round(p.x+Math.cos(dir)*dis), Math.round(p.y+Math.sin(dir)*dis));
		}else{
			return new Point(p.x+Math.cos(dir)*dis, p.y+Math.sin(dir)*dis);
		}
	}	
	
	public static function getDisabledColor(c:Component):ASColor{
		var bg:ASColor = c.getBackground();
		if(bg == null) bg = ASColor.BLACK;
		return disabledColor(bg);
	}
	
	public static function disabledColor(cl:ASColor):ASColor{
		var bg:ASColor = cl;
		var hue:Float= bg.getHue();
		var lum:Float= bg.getLuminance();
		var sat:Float= bg.getSaturation();
		if(lum < 0.6){
			lum += 0.1;
		}else{
			lum -= 0.1;
		}
		sat -= 0.2;
		return ASColor.getASColorWithHLS(hue, lum, sat, bg.getAlpha());
	}	
	
	/**
	 * For buttons style bezel by fill function
	 */
	public static function drawUpperedBezel(g:Graphics2D, r:IntRectangle,
                                    shadow:ASColor, darkShadow:ASColor, 
                                 highlight:ASColor, lightHighlight:ASColor):Void{
		var x1:Float= r.x;
		var y1:Float= r.y;
		var w:Float= r.width;
		var h:Float= r.height;
		
		var brush:SolidBrush = new SolidBrush(darkShadow);
		g.fillRectangleRingWithThickness(brush, x1, y1, w, h, 1);
		
        brush.setColor(lightHighlight);
        g.fillRectangleRingWithThickness(brush, x1, y1, w-1, h-1, 1);
        
        brush.setColor(highlight);
        g.fillRectangleRingWithThickness(brush, x1+1, y1+1, w-2, h-2, 1);
        
        brush.setColor(shadow);
        g.fillRectangle(brush, x1+w-2, y1+1, 1, h-2);
        g.fillRectangle(brush, x1+1, y1+h-2, w-2, 1);
	}
	
	/**
	 * For buttons style bezel by fill function
	 */
	public static function drawLoweredBezel(g:Graphics2D, r:IntRectangle,
                                    shadow:ASColor, darkShadow:ASColor, 
                                 highlight:ASColor, lightHighlight:ASColor):Void{
                                 	
		var x1:Float= r.x;
		var y1:Float= r.y;
		var w:Float= r.width;
		var h:Float= r.height;
		
        var brush:SolidBrush = new SolidBrush(darkShadow);
		g.fillRectangleRingWithThickness(brush, x1, y1, w, h, 1);
		
		brush.setColor(darkShadow);
        g.fillRectangleRingWithThickness(brush, x1, y1, w-1, h-1, 1);
        
        brush.setColor(highlight);
        g.fillRectangleRingWithThickness(brush, x1+1, y1+1, w-2, h-2, 1);
        
        brush.setColor(highlight);
        g.fillRectangle(brush, x1+w-2, y1+1, 1, h-2);
        g.fillRectangle(brush, x1+1, y1+h-2, w-2, 1);
	}
	
	/**
	 * For buttons style bezel by fill function
	 */	
	public static function drawBezel(g:Graphics2D, r:IntRectangle, isPressed:Bool, 
                                    shadow:ASColor, darkShadow:ASColor, 
                                 highlight:ASColor, lightHighlight:ASColor):Void{
                                 
        if(isPressed)	{
            drawLoweredBezel(g, r, shadow, darkShadow, highlight, lightHighlight);
        }else {
        	drawUpperedBezel(g, r, shadow, darkShadow, highlight, lightHighlight);
        }
	}
	
	/**
	 * For buttons  by draw line function
	 */	
	public static function paintBezel(g:Graphics2D, r:IntRectangle, isPressed:Bool, 
                                    shadow:ASColor, darkShadow:ASColor, 
                                 highlight:ASColor, lightHighlight:ASColor):Void{
                                 
        if(isPressed)	{
            paintLoweredBevel(g, r, shadow, darkShadow, highlight, lightHighlight);
        }else {
        	paintRaisedBevel(g, r, shadow, darkShadow, highlight, lightHighlight);
        }
	}	
	
	/**
	 * Use drawLine 
	 */
    public static function paintRaisedBevel(g:Graphics2D, r:IntRectangle,
                                    shadow:ASColor, darkShadow:ASColor, 
                                 highlight:ASColor, lightHighlight:ASColor):Void{
        var h:Float= r.height - 1;
        var w:Float= r.width - 1;
        var x:Float= r.x + 0.5;
        var y:Float = r.y + 0.5;
		 
	 /*(color:ASColor,
				 ?thickness:Float=1, 
				 ?pixelHinting:Bool= false, 
				 ?scaleMode:LineScaleMode= null, 
				 ?caps:CapsStyle= null, 
				 ?joints:JointStyle= null, 
				 ?miterLimit:Float= 3) 
				 */
//why	
	 				 
        var pen:Pen = new Pen(lightHighlight, 1, false, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
        g.drawLine(pen, x, y, x, y+h-2);
        g.drawLine(pen, x+1, y, x+w-2, y);
		
		pen.setColor(highlight);
        g.drawLine(pen, x+1, y+1, x+1, y+h-3);
        g.drawLine(pen, x+2, y+1, x+w-3, y+1);

		pen.setColor(darkShadow);
        g.drawLine(pen, x, y+h-1, x+w-1, y+h-1);
        g.drawLine(pen, x+w-1, y, x+w-1, y+h-2);

		pen.setColor(shadow);
        g.drawLine(pen, x+1, y+h-2, x+w-2, y+h-2);
        g.drawLine(pen, x+w-2, y+1, x+w-2, y+h-3);
	 
    }
    
	/**
	 * Use drawLine 
	 */
    public static function paintLoweredBevel(g:Graphics2D, r:IntRectangle,
                                    shadow:ASColor, darkShadow:ASColor, 
                                 highlight:ASColor, lightHighlight:ASColor):Void{
        var h:Float= r.height - 1;
        var w:Float= r.width - 1;
        var x:Float= r.x + 0.5;
        var y:Float = r.y + 0.5;
		
		//why	
	 
		var pen:Pen = new Pen(shadow, 1, false, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
        g.drawLine(pen, x, y, x, y+h-1);
        g.drawLine(pen, x+1, y, x+w-1, y);

       	pen.setColor(darkShadow);
        g.drawLine(pen, x+1, y+1, x+1, y+h-2);
        g.drawLine(pen, x+2, y+1, x+w-2, y+1);

        pen.setColor(lightHighlight);
        g.drawLine(pen, x+1, y+h-1, x+w-1, y+h-1);
        g.drawLine(pen, x+w-1, y+1, x+w-1, y+h-2);

        pen.setColor(highlight);
        g.drawLine(pen, x+2, y+h-2, x+w-2, y+h-2);
        g.drawLine(pen, x+w-2, y+2, x+w-2, y+h-3);
	 
    }
    
    public static function paintButtonBackGround(c:AbstractButton, g:Graphics2D, b:IntRectangle):Void{
		var bgColor:ASColor = (c.getBackground() == null ? ASColor.WHITE : c.getBackground());
		if(c.isOpaque()){
			if(c.getModel().isArmed() || c.getModel().isSelected() || !c.isEnabled()){
				g.fillRectangle(new SolidBrush(bgColor), b.x, b.y, b.width, b.height);
			}else{
				drawControlBackground(g, b, bgColor, Math.PI/2);
			}
		}
    }

	public static function drawControlBackground(g:Graphics2D, b:IntRectangle, bgColor:ASColor, direction:Float):Void{
		g.fillRectangle(new SolidBrush(bgColor), b.x, b.y, b.width, b.height);
		var x:Float= b.x;
		var y:Float= b.y;
		var w:Float= b.width;
		var h:Float= b.height;
        var colors:Array<Int>= [0xFFFFFF, 0xFFFFFF];
		var alphas:Array<Dynamic>= [0.75, 0];
		var ratios:Array<Dynamic>= [0, 100];
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(w, h, direction, x, y);       
        var brush:GradientBrush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
        g.fillRectangle(brush, x, y, w, h);
	}
	
	public static function fillGradientRect(g:Graphics2D, b:IntRectangle, c1:ASColor, c2:ASColor, direction:Float, ratios:Array<Dynamic>=null):Void{
		var x:Float= b.x;
		var y:Float= b.y;
		var w:Float= b.width;
		var h:Float= b.height;
        var colors:Array<Int>= [c1.getRGB(), c2.getRGB()];
		var alphas:Array<Dynamic>= [c1.getAlpha(), c2.getAlpha()];
		if(ratios == null){
			ratios = [0, 255];
		}
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(w, h, direction, x, y);       
        var brush:GradientBrush = new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix);
        g.fillRectangle(brush, x, y, w, h);
	}    
}