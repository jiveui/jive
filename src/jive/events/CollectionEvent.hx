package jive.events;

import openfl.events.Event;

class CollectionEvent extends Event {
    public inline static var COLLECTION_ADDED: String = "CollectionEvent_CollectionAdded";
    public inline static var COLLECTION_REMOVED: String = "CollectionEvent_CollectionRemoved";

    public function new(type:String, bubbles:Bool = false, cancelable:Bool = false) {
        super(type, bubbles, cancelable);
    }
}