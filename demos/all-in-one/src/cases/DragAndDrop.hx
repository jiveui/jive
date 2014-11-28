package cases;


import flash.display.Sprite;
class DragAndDrop extends Sprite , implements DragListener{
	
	private var tracedText:JTextArea;
	private var destPane:Container;
	private var controls:Container;
	private var frame:JFrame;
	
	public function new(){
		super();
		frame = new JFrame(null, "DragAndDrop");
		
		var pane:Container = frame.getContentPane();
		pane.setLayout(new BoxLayout(BoxLayout.Y_AXIS));
		
		destPane = new JPanel(new FlowLayout());
		//destPane.setBorder(new TitledBorder(null, "DnD container"));
		destPane.setDropTrigger(true);
		
		//var conPane:Container = Box.createHorizontalBox();
		var conPane:Container = new JPanel(new BoxLayout(BoxLayout.X_AXIS));
		controls = new JPanel(new FlowLayout());
		//controls.setBorder(new TitledBorder(null, "DnD container"));
		controls.append(creatDragableComponent());
		controls.append(creatDragableComponent());
		controls.append(creatDragableComponent());
		controls.append(creatDragableComponent());
		controls.setDropTrigger(true);
		conPane.append(controls);
		
		conPane.append(destPane);
		
		pane.append(conPane);
		tracedText = new JTextArea();
		tracedText.setDropTrigger(true);
		pane.append(new JScrollPane(tracedText));
		
		
		frame.setLocationXY(10, 10);
		frame.setSizeWH(400, 400);
		frame.show();
	}
	

	private static var counter:Float= 0;
	private function creatDragableComponent():Component{
		counter ++;
		var dc:Component;
		if(counter == 3){
			dc = new JButton("Drag me " + counter);
		}else{
			dc = new JLabel("Drag me " + counter);
		}
		dc.setDragEnabled(true);
		destPane.addDragAcceptableInitiator(dc);
		dc.addEventListener(DragAndDropEvent.DRAG_RECOGNIZED, __startDrag);
		return dc;
	}
	
	private function __startDrag(e:DragAndDropEvent):Void{
		traceText("try to start Drag " + e.getDragInitiator());
		DragManager.startDrag(e.getDragInitiator(), null, null, this);
	}	
	
	private function traceText(text:String):Void{
		tracedText.appendText(text+"\n");
		tracedText.scrollToBottomLeft();
		trace(text);
	}

	public function onDragStart(e:DragAndDropEvent):Void{
		traceText("onDragStart : " + e.getDragInitiator());
	}
	
	public function onDragEnter(e:DragAndDropEvent):Void{
		traceText("onDragEnter " + e.getTargetComponent() + "/nfrom " + e.getRelatedTargetComponent());
	}
	
	public function onDragOverring(e:DragAndDropEvent):Void{
		//traceText("onDragOverring : " + e.getTargetComponent());
	}
	
	public function onDragExit(e:DragAndDropEvent):Void{
		traceText("onDragExit from " + e.getTargetComponent() + "\nto " + e.getRelatedTargetComponent());
	}
	
	public function onDragDrop(e:DragAndDropEvent):Void{
		traceText("onDragDrop : " + e.getDragInitiator());
		var targetComponent:Component = e.getTargetComponent();
		var dragInitiator:Component = e.getDragInitiator();
		if(targetComponent == controls || targetComponent == destPane){
			if(targetComponent.isDragAcceptableInitiator(dragInitiator)){
				var ct:Container = Container(targetComponent);
				dragInitiator.removeFromContainer();
				ct.append(dragInitiator);
				trace("ct children : " + ct.getComponentCount());
				ct.removeDragAcceptableInitiator(dragInitiator);
				if(targetComponent == controls){
					destPane.addDragAcceptableInitiator(dragInitiator);
				}else{
					controls.addDragAcceptableInitiator(dragInitiator);
				}
			}else{
				DragManager.setDropMotion(new RejectedMotion());
			}
			//dragInitiator.revalidate();
		}else if(Std.is(targetComponent,JTextArea)){
			var jta:JTextArea = JTextArea(targetComponent);
			var label:JLabel = flash.Lib.as(dragInitiator,JLabel)	;
			var text:String= label == null ? dragInitiator.getName() : label.getText();
			traceText("hello '" + text + "' don't drop on me!");
			DragManager.setDropMotion(new RejectedMotion());
		}else{
			DragManager.setDropMotion(new RejectedMotion());
		}		
	}
}