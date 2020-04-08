package jive;

import org.aswing.event.PropertyChangeEvent;
import flash.events.EventDispatcher;

class PickerModel extends EventDispatcher {

    public var visibleItems: Int = 5;

    private var _selected: Dynamic;
    public var selected (get, set): Dynamic;

    public function get_selected() { return _selected; }

    public function set_selected(s: Dynamic): Dynamic {
        if (s == _selected) return _selected;

        var old = _selected;
        _selected = s;
        dispatchEvent(new PropertyChangeEvent("selected", old, _selected));
        return _selected;
    }

    private var _items: Array<Dynamic>;

    public var items (get, set): Array<Dynamic>;

    public function get_items() { return _items; }
    public function set_items(value) {
        var old = _items;
        _items = value;
        return _items;
    }

    public function new(items: Array<Dynamic>) {
        super();
        this.items = items;
    }

    public function updateBySelectedIndex(index: Int) {
        selected = items[index];
    }

    public function getSelectedIndex(): Int {
        return if (null != items) Lambda.indexOf(items, selected) else -1;
    }
}
