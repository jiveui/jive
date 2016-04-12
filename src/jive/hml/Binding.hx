package jive.hml;

using StringTools;

class Binding {
    public var propertyName: String;
    public var mode: BindingMode = BindingMode.oneway;

    public function new() {}

    public static function fromString(s: String): Binding {
        var b = new Binding();
        var trimmed = s.replace('{Binding','').replace('}','').trim();
        var name = trimmed;

        if (trimmed.indexOf(" ") >= 0) {
            var splitted = trimmed.split(" ");
            name = splitted[0];
            if (splitted[1].startsWith("mode=")) {
                var m = splitted[1].split("=");
                b.mode = Type.createEnum(BindingMode, m[1]);
            }
        }

        b.propertyName = name;
        return b;
    }
}
