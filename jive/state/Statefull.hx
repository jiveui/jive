package jive.state;

import haxe.ds.StringMap;

interface Statefull {
    var state(default, set): String;
    var states(default, set): States;
}
