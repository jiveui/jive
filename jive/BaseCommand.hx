package jive;

class BaseCommand extends Command {

    private var actionHandler: Void -> Void;

    public function new(actionHandler: Void -> Void) {
        this.actionHandler = actionHandler;
    }

    public override function action() {
        if (null != actionHandler) actionHandler();
    }
}
