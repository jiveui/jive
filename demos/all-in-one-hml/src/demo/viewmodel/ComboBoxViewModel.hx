package demo.viewmodel;

import openfl.Assets;
import bindx.IBindable;

class ComboBoxViewModel implements IBindable implements Spotable {

    @:bindable public var email(get, set): String;
    private var _email: String;
    private function get_email(): String { return _email; }
    private function set_email(v:String): String { _email = v;  return v;  }

    @:bindable public var password(get, set): String;
    private var _password: String;
    private function get_password(): String { return _password; }
    private function set_password(v:String): String { _password = v;  return v;  }

    @:bindable public var role: Int = 0;

    @:bindable public var xmlSource: String = Assets.getText("assets/source/ComboBoxView.hml");
    @:bindable public var haxeSource: String = Assets.getText("assets/source/ComboBoxViewModel.hx");

    @:bindable public var selectedSpotIndex(get, set): Int;
    private var _selectedSpotIndex: Int;
    private function get_selectedSpotIndex(): Int { return _selectedSpotIndex; }
    private function set_selectedSpotIndex(v: Int): Int {
        _selectedSpotIndex = v;
        return v;
    }
    public function new() {}
}
