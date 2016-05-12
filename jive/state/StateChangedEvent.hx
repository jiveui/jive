package jive.state;

class StateChangedEvent extends openfl.events.Event {
    public static var STATE_CHANGED: String = "jive-state-changed";

    public var previous: State;
    public var current: State;

    public function new(prev: State, cur: State) {
        previous = prev;
        current = cur;
        super(STATE_CHANGED);
    }
}
