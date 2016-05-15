package jive;

import openfl.display.Sprite;
import openfl.display.DisplayObject;
import jive.geom.IntDimension;

class ScrolledContainer extends Container {
    override private function get_displayObjectContainer():Sprite {
        if (null == displayObjectContainer) {
            displayObjectContainer = createDisplayObjectContainer();
            displayObjectContainer.name = "container";

        }
        return displayObjectContainer;
    }

    override private function get_displayObject():DisplayObject {
        if (null == displayObject){
            var wrap = new Sprite();

            wrap.addChild(displayObjectContainer);

            displayObject = wrap;

            wrap.name = "wrapper";
        }

        return displayObject;
    }

    override private function createDisplayObject():DisplayObject {
        return displayObject;
    }

    // override public function paint(size: IntDimension):IntDimension {
        
    //     //Jive.printChildren(displayObjectContainer, '');

    //     trace(displayObjectContainer.parent == displayObjectContainer);

    //     Jive.printChildren( cast(displayObject, Sprite), '' );

    //     return super.paint(size);
    // } 
}