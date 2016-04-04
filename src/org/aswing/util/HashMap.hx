/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.util;
import haxe.ds.IntMap;


class HashMap < K, V > {
    private var _keys:Array<K>;
    private var _values:IntMap<V>;
    private var length:Int;
/** @private */ private static var nextObjectID:Int = 0;

    public function new() {
        this._keys = new Array<K>();
        this._values = new IntMap<V>() ;


        length = 0;
    }


    private inline function getID(val:K):Int {

        var exists:Int = -1;
        for (i in 0..._keys.length) {
            if (_keys[i] != null) {
                if (_keys[i] == val) {
                    exists = i;
                    break;
                }
            }
        }
        return exists;
    }

    private inline function pushID(val:K):Void {

        var exists:Int = getID(val);

        if (exists == -1) {
            _keys.push(val);
        }

    }

    public inline function set(k:K, v:V) {
        if (!exists(k)) length++;
        pushID(k);
        this._values.set(getID(k), v);
    }

    public inline function get(k:K) {
        return this._values.get(getID(k));
    }

    public inline function exists(k:K) {
        return this._values.exists(getID(k));
    }

    public inline function remove(k:K) {
        if (!exists(k)) length--;
        this._values.remove(getID(k));


        return this._keys.remove(k);
    }

    public inline function keys() {
        return this._keys.iterator();
    }

    public inline function values() {
        return this._values.iterator();
    }

    public inline function iterator() {
        return this._values.iterator();
    }


//-------------------public methods--------------------

/**
  * Returns the number of keys in this HashMap.
  */

    public function size():Int {
        return length;
    }

/**
  * Returns if this HashMap maps no keys to values.
  */

    public function isEmpty():Bool {
        return (length == 0);
    }


/**
 * Call func(key) for each key.
 * @param func the function to call
 */

    public function eachKey(func:Dynamic -> Void):Void {

        for (i in keys()) {
            func(i);
        }
    }

/**
 * Call func(value) for each value.
 * @param func the function to call
 */

    public function eachValue(func:Dynamic -> Void):Void {
        for (i in iterator()) {
            func(i);
        }
    }

/**
  * Tests if some key maps into the specified value in this HashMap.
  * This operation is more expensive than the containsKey method.
  */

    public function containsValue(value:V):Bool {
        var itr:Iterator<V> = values();
        for (i in itr) {
            if (i == value) {
                return true;
            }
        }
        return false;
    }

/**
  * Tests if the specified object is a key in this HashMap.
  * This operation is very fast if it is a string.
* @param   key   The key whose presence in this map is to be tested
* @return <tt>true</tt> if this map contains a mapping for the specified
  */

    public function containsKey(key:K):Bool {

        return exists(key);
    }


/**
 * Same functionity method with different name to <code>get</code>.
 *
* @param   key the key whose associated value is to be returned.
* @return  the value to which this map maps the specified key, or
*          <tt>null</tt> if the map contains no mapping for this key
*           or it is null value originally.
 */

    public function getValue(key:K):Dynamic {
        return get(key);
    }

/**
 * Associates the specified value with the specified key in this map.
 * If the map previously contained a mapping for this key, the old value is replaced.
 * If value is null, means remove the key from the map.
* @param key key with which the specified value is to be associated.
* @param value value to be associated with the specified key. null to remove the key.
* @return previous value associated with specified key, or <tt>null</tt>
*	       if there was no mapping for key.  A <tt>null</tt> return can
*	       also indicate that the HashMap previously associated
*	       <tt>null</tt> with the specified key.
  */

    public function put(key:K, value:V):V {

        set(key, value);
        return value;
    }

/**
 * Clears this HashMap so that it contains no keys no values.
 */

    public function clear():Void {
        var itr:Iterator<K> = keys();
        for (i in itr) {
            remove(i);
        }
        length = 0;
    }

/**
 * Return a same copy of HashMap object
 */

    public function clone():HashMap<K, V> {
        var temp:HashMap<K, V> = new HashMap<K, V>();
        var itr:Iterator<K> = keys();
        for (i in itr) {
            temp.put(i, get(i));
        }
        return temp;
    }

}