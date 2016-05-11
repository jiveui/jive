package jive.state;

import haxe.ds.StringMap;

interface Statefull {
    var state(get, set): String;
    var states(get, set): States;
}
