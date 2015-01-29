/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import flash.display.Loader;
import flash.display.DisplayObjectContainer;
import flash.display.DisplayObject;
import flash.display.LoaderInfo;
import flash.events.Event;
 
import flash.events.IOErrorEvent; 
import flash.net.URLRequest; 

/**
 * JLoadPane, a container load a external image/animation to be its asset.
 * @author paling
 */
@:event("flash.events.Event.COMPLETE","Dispatched when data has loaded successfully. The complete event is always dispatched after the init event")
@:event("flash.events.HTTPStatusEvent.HTTP_STATUS", "Dispatched when a network request is made over HTTP and Flash Player can detect the HTTP status code")
@:event("flash.events.Event.INIT", "Dispatched when the properties and methods of a loaded SWF file are accessible. A LoaderInfo object dispatches the init event when the following two conditions exist")
@:event("flash.events.IOErrorEvent.IO_ERROR", "Dispatched when an input or output error occurs that causes a load operation to fail")
@:event("flash.events.Event.OPEN", "Dispatched when a load operation starts")
@:event("flash.events.ProgressEvent.PROGRESS", "Dispatched when data is received as the download operation progresses")
@:event("flash.events.Event.UNLOAD", "Dispatched by a LoaderInfo object whenever a loaded object is removed by using the unload() method of the Loader object or when a second load is performed by the same Loader object and the original content is removed prior to the load beginning")
class JLoadPane extends AssetPane {
	
	public var loader(default, null):Loader;

    /**
	 * @see flash.events.IOErrorEvent.IO_ERROR
	 */
    public var error(default, null):Bool;

	public var urlRequest(default, null):URLRequest;

    public var url(get, set): String;
    private var _url: String;
    private function get_url(): String { return if (null != urlRequest) urlRequest.url else null;  }
    private function set_url(v: String): String {
        error = false;
        if(v == null){
            urlRequest = null;
        }else{
            urlRequest = new URLRequest(v);
        }
        loadAsset();
        return v;
    }

	private var regularAssetContainer:DisplayObjectContainer;
	
	/**
	 * Creates a JLoadPane with a path to load external image or animation file.
	 * <p>The asset of the JLoadPane will only be available after load completed. It mean 
	 * <code>AssetPane.asset</code> will return null before load completed.</p>
	 * @param url the path string or a URLRequst instance, null to make it do not load any thing.
	 * @param prefferSizeStrategy the prefferedSize count strategy. Must be one of below:
	 * <ul>
	 * <li>`org.aswing.AssetPane#PREFER_SIZE_BOTH`
	 * <li>`org.aswing.AssetPane#PREFER_SIZE_IMAGE`
	 * <li>`org.aswing.AssetPane#PREFER_SIZE_LAYOUT`
	 * </ul>
	 * @param context the loader context.
	 */
	public function new(url:Dynamic=null, prefferSizeStrategy:Int=1 ) {
		super(null, prefferSizeStrategy);
		setName("JLoadPane");
		error = false;
		if(url == null){
			urlRequest = null;
		}else if(Std.is(url,URLRequest)){
			urlRequest = AsWingUtils.as(url,URLRequest)	;
		}else{
			urlRequest = new URLRequest(AsWingUtils.as(url , String));
		}
		 
		regularAssetContainer = assetContainer;
		loader = createLoader();
		loadAsset();
	}
	
	@:dox(hide)
    override public function setAsset(asset:DisplayObject):Void{
		if(assetContainer == loader){
			assetContainer = regularAssetContainer;
			removeChild(loader);
			loader.mask = null;
			addChild(assetContainer);
			bringToBottom(assetContainer);
			applyMaskAsset();
		}
		super.setAsset(asset);
	}
	
	/**
	 * Sets the asset loaded by JLoadPane's loader.
	 */
	private function setLoadedAsset(asset:DisplayObject):Void{
		if(assetContainer == regularAssetContainer){
			assetContainer = loader;
			if (this.contains(regularAssetContainer)){
				if(this._asset!=null && regularAssetContainer.contains(this._asset)){
					regularAssetContainer.removeChild(this._asset);
				}
				removeChild(regularAssetContainer);
				regularAssetContainer.mask = null;
			}
			addChild(assetContainer);
			bringToBottom(assetContainer);
			applyMaskAsset();
		}
		this._asset = asset;
		storeOriginalScale();
		setLoaded(asset != null);
		resetAsset();
	}
	
	/**
	 * Load the asset.
	 * <p>The asset of the JLoadPane will only be available after load completed. It mean 
	 * <code>AssetPane.asset</code> will return null before load completed.</p>
	 * @param request The absolute or relative URL of the SWF, JPEG, GIF, or PNG file to be loaded. 
	 * 		A relative path must be relative to the main SWF file. Absolute URLs must include 
	 * 		the protocol reference, such as http:// or file:///. Filenames cannot include disk drive specifications. 
	 * @param context (default = null) A LoaderContext object.
	 * @see flash.display.Loader#load()
	 */
	public function load(request:URLRequest ):Void{
		this.urlRequest = request;
		loadAsset();
	}
	
	/**
	 * unload the loaded asset;
	 */
    @:dox(hide)
	override public function unloadAsset():Void{
		this.urlRequest = null;
		 
		if(assetContainer == loader){ 
			this._asset = null;
			setLoaded(false);
			resetAsset();
		}else{
			super.unloadAsset();
		}
	}
	
	/**
	 * return the path of image/animation file
	 * @return the path of image/animation file
	 */
    @:dox(hide)
	public function getURLRequest():URLRequest{
		return urlRequest;
	}	
	
	/**
	 * Reload the asset with the last url request and context.
	 */
	override public function reload():Void{
		loadAsset();
	}
	
	/**
	 * Returns is error loaded.
	 * @see #ON_LOAD_ERROR
	 */
    @:dox(hide)
	public function isLoadedError():Bool{
		return error;
	}
	
	private function loadAsset():Void{
		if(urlRequest != null){
			error = false;
			setLoaded(false);
			loader.load(urlRequest);
		}
	}
	
	private function createLoader():Loader{
		loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __onLoadComplete);
		loader.contentLoaderInfo.addEventListener(Event.INIT, __onLoadInit);
		loader.contentLoaderInfo.addEventListener(Event.OPEN, __onLoadStart);
		loader.contentLoaderInfo.addEventListener(Event.UNLOAD, __onUnload);
		//loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, __onLoadHttpStatus);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __onLoadError);	
		//loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, __onLoadProgress);
		return loader;
	}
	
	/**
	 * Returns a object contains <code>bytesLoaded</code> and <code>bytesTotal</code> 
	 * properties that indicate the current loading status.
	 */
	
	/*
	public function getProgress():ProgressEvent{
		return new ProgressEvent(ProgressEvent.PROGRESS, false, false, 
			loader.contentLoaderInfo.bytesLoaded, 
			loader.contentLoaderInfo.bytesTotal);
	}
	*/
    @:dox(hide)
	public function getAssetLoaderInfo():LoaderInfo{
		return loader.contentLoaderInfo;
	}
	
	@:dox(hide)
    public function getLoader():Loader{
		return loader;
	}
	
	//-----------------------------------------------

	private function __onLoadComplete(e:Event):Void{
		setLoadedAsset(loader.content);
		dispatchEvent(new Event(Event.COMPLETE));
	}
	
	private function __onLoadError(e:IOErrorEvent):Void{
		error = true;
		setLoadedAsset(loader.content);
		dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, e.toString()));
	}
	
	private function __onLoadInit(e:Event):Void{
		dispatchEvent(new Event(Event.INIT));
	}
	/*
	private function __onLoadProgress(e:ProgressEvent):Void{
		dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, e.bytesLoaded, e.bytesTotal));
	}
	*/ 
	private function __onLoadStart(e:Event):Void{
		dispatchEvent(new Event(Event.OPEN));
	}
	
	private function __onUnload(e:Event):Void{
		dispatchEvent(new Event(Event.UNLOAD));
	}
	/*
	private function __onLoadHttpStatus(e:HTTPStatusEvent):Void{
		dispatchEvent(new HTTPStatusEvent(HTTPStatusEvent.HTTP_STATUS,false,false,e.status));		
	}
	*/ 
}