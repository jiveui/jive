package jive;

class BaseCommand implements Command {

    private var actionHandler: Void -> Void;

    public function new(actionHandler: Void -> Void) {
        this.actionHandler = actionHandler;
    }

    public function action() {
        if (null != actionHandler) actionHandler();
    }
}
