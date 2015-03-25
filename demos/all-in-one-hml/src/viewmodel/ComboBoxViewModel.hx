package viewmodel;

import bindx.IBindable;

class ComboBoxViewModel implements IBindable {

    @bindable public var email(get, set): String;
    private var _email: String;
    private function get_email(): String { return _email; }
    private function set_email(v:String): String { _email = v;  return v;  }

    @bindable public var password(get, set): String;
    private var _password: String;
    private function get_password(): String { return _password; }
    private function set_password(v:String): String { _password = v;  return v;  }

    @bindable public var role: Int = 0;


    public function new() {}
}
