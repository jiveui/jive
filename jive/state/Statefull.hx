package jive.state;

interface Statefull {
    var state: State;
    var states: Array<State>;
    function moveToState(name: String): Void;
    function addStateListener(listener: StateEvent -> Void): Void;
    function removeStateListener(listener: StateEvent -> Void): Void;
}
