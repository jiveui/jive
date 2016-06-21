package jive.tools;

class CachedFunction<T> {
    private var validated: Bool = false;

    public var value(get, null): T;
    private function get_value(): T {
        run();
        return value;
    }

    public dynamic function func(): T { return null; }

    public function invalidate() {
        validated = false;
    }

    public function run() {
        if (!validated) {
            value = func();
            validated = true;
        }
    }
}
