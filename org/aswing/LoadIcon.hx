/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.graphics.Graphics2D;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
import flash.display.Sprite; 

/**
 * LoadIcon allow you load extenal image/animation to be the icon content.
 * @author senkay
 */
class LoadIcon extends AssetIcon{
	
	private var loader:Loader;
	private var owner:Component;
	private var urlRequest:URLRequest; 
	private var needCountSize:Bool;
	
	/**
	 * Creates a LoadIcon with specified url/URLRequest, width, height.
	 * @param url the url/URLRequest for a asset location.
	 * @param width (optional)the width of this icon.(miss this param mean use image width)
	 * @param height (optional)the height of this icon.(miss this param mean use image height)
	 * @param scale (optional)whether scale the extenal image/anim to fit the size 
	 * 		specified by front two params, default is false
	 */
	public function new(url:Dynamic, width:Float=-1, height:Float=-1, scale:Bool=false){
		super(getLoader(),Std.int(width), Std.int(height), false);
		this.scale = scale;
		if(Std.is(url,URLRequest)){
			urlRequest = url;
		}else{
			urlRequest = new URLRequest(url);
		} 
		needCountSize = (width == -1 || height == -1);
		getLoader().load(urlRequest);
	}
	
	/**
	 * Return the loader
	 * @return this loader
	 */
	public function getLoader():Loader{
		if (loader == null){
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __onLoadError);
		}
		return loader;
	}
	
	/**
	 * when the loader init updateUI
	 */
	private function __onComplete(e:Event):Void{
		if(needCountSize)	{
			setWidth(Std.int(loader.width));
			setHeight(Std.int(loader.height));
		}
		if(scale)	{
			loader.width = width;
			loader.height = height;
		}
		if(owner!=null)	{
			owner.repaint();
			owner.revalidate();	
		}
	}
	
	private function __onLoadError(e:IOErrorEvent):Void{
		//do nothing
	}
	

	override public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		super.updateIcon(c, g, x, y);
		owner = c;
	}
	
	override public function getIconHeight(c:Component):Int{
		owner = c;
		return super.getIconHeight(c);
	}
	
	override public function getIconWidth(c:Component):Int{
		owner = c;
		return super.getIconWidth(c);
	}
	
	override public function getDisplay(c:Component):DisplayObject{
		owner = c;
		return super.getDisplay(c);
	}
	
	public function clone():LoadIcon{
		return new LoadIcon(urlRequest, needCountSize ? -1 : width, needCountSize ? -1 : height, scale);
	}
}