package jive;

class Container extends Component {

    public var children: Collection<Component>;

    public function new() {
        super();
        children = new Collection();
    }
}