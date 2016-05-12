package jive.state;

class State {
    public static var CHANGING: String = "changing";
    public var key: String;
    public var transformations: Transformations;

    public function new() {}
}
