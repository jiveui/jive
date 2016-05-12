package jive;

import flash.events.MouseEvent;
import openfl.geom.Rectangle;
//import jive.gestures.PanGesture;
//import jive.gestures.Gestures;
//import jive.gestures.events.GestureEvent;

class Scroll extends Container {
//    private var gestures: Gestures;
//    private var pan: PanGesture;

    public function new() {
        super();

        /*Gestures.init();

        pan = new PanGesture();
        pan.direction = PanGesture.VERTICAL;

        gestures = new Gestures(this);
        gestures.gesturesManager.addGesture(pan);

        pan.addEventListener(GestureEvent.GESTURE_CHANGED, onPan);*/
        //displayObjectContainer.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
    }

   /* private function mouseDown(e: MouseEvent) {
        displayObjectContainer.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
        displayObjectContainer.startDrag(false, new Rectangle(0, 0, absoluteWidth * 2, absoluteHeight * 2));
    }

    private function mouseUp(e: MouseEvent) {
        displayObjectContainer.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
        displayObjectContainer.stopDrag();
    }*/

    override private function set_parent(c:Container):Container {
        super.set_parent(c);

        displayObjectContainer.graphics.lineStyle(1, 0);
        displayObjectContainer.graphics.drawRect(0, 0, absoluteWidth, absoluteHeight);

        return c;
    }

    override public function append(child:Component) {
        if (children.length > 0) {
            remove(children.get(0));
        }
        children.add(child);
        child.parent = this;
        displayObjectContainer.addChild(child.displayObject);
        child.repaint();
    }

    override public function insert(index:Int, child:Component) {
        append(child);
    }

    override public function remove(child:Component) {
        if (children.get(0) == child) {
            children.remove(child);
            displayObjectContainer.removeChild(child.displayObject);
            child.parent = null;
            repaint();
        }
    }

    /*function onPan(event:GestureEvent) {
        if (children.length > 0) {
            trace(displayObject.scrollRect.y - pan.offsetY);
            children.get(0).displayObject.scrollRect = new Rectangle(0, children.get(0).displayObject.scrollRect.y - pan.offsetY, children.get(0).absoluteWidth, children.get(0).absoluteHeight);
        }
    }*/
}
