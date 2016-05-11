package jive;

import openfl.geom.Rectangle;
import jive.gestures.PanGesture;
import jive.gestures.Gestures;
import jive.gestures.events.GestureEvent;

class Scroll extends Container {
    private var gestures: Gestures;
    private var pan: PanGesture;

    public function new() {
        super();

        Gestures.init();

        pan = new PanGesture();
        pan.direction = PanGesture.HORIZONTAL;

        gestures = new Gestures(this);
        gestures.gesturesManager.addGesture(pan);

        pan.addEventListener(GestureEvent.GESTURE_CHANGED, onPan);
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

    function onPan(event:GestureEvent) {
        displayObject.scrollRect = new Rectangle(0, displayObject.scrollRect.y - pan.offsetY, absoluteWidth, absoluteHeight);
    }
}
