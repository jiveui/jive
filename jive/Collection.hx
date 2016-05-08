package jive;

import openfl.events.EventDispatcher;

import jive.events.CollectionEvent;

/**
* collection class with events support
**/
class Collection<T> extends EventDispatcher {
    private var elements:Array<T>;

    /**
    * collection elements count
    **/
    public var length(get, never):Int;

    private function get_length():Int {
        return elements.length;
    }

    public function new() {
        super();
        elements = new Array();
    }

    /**
    * add element to collection
    * @param element    element to add
    * @param index      position to add. If 'index<0' element would be added to the end
    **/

    public function add(element:T, index:Int = -1):Void {
        if (index < 0)
            elements.push(element);
        else
            elements.insert(index, element);

        dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_ADDED));
    }

    /**
    * get element at index
    * @param index      position of element, if there is no element returns null (or should throw exception)
    **/

    public function get(index:Int):T {
        if (index >= 0 && index < elements.length) {
            return elements[index];
        }
        return null;
    }

    /**
    * remove element from collection
    * @param element    element to remove. If it is 'null' all elements would be removed.
    **/

    public function remove(element:T = null):Void {
        if (element != null)
            elements.remove(element);
        else
            elements.splice(0, -1);

        dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_REMOVED));
    }


    @:dox(hide)
    public function iterator():Iterator<T> {
        return elements.iterator();
    }
}
