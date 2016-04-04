package jive;

class TemplatedComponent extends Component {
    public var template: Class<Dynamic>;
    public var viewModel: ViewModel;
    public function new() {
        super();
    }
}
