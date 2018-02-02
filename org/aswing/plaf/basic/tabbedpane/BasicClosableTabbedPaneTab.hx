/**

 * The basic imp for ClosableTab

 * @author iiley

 */
package org.aswing.plaf.basic.tabbedpane;

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.events.Event;
import org.aswing.GroundDecorator;
import org.aswing.border.EmptyBorder;
import org.aswing.event.InteractiveEvent;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

class BasicClosableTabbedPaneTab implements ClosableTab implements GroundDecorator implements UIResource {

	private var panel : Container;
	private var label : JButton;
	private var button : AbstractButton;
	private var margin : Insets;
	private var owner : Component;
	private var placement : Int;
	private var shape : Shape;
	public function new() {
		 
		shape = new Shape();
	}

	public function getDisplay(c : Component) : DisplayObject {
		return shape;
	}

	public function updateDecorator(c : Component, g : Graphics2D, b : IntRectangle) : Void {
		shape.graphics.clear();
		if(owner!=null)  {
			c = owner;
		}
		b = margin.getOutsideBounds(b);
		var btn : AbstractButton = label;
		if(btn!=null)  {
			var model : ButtonModel = btn.getModel();
			var isPressing : Bool = model.isPressed() || model.isSelected();
			g = new Graphics2D(shape.graphics);
			var cl : ASColor = c.getMideground();
			var style : StyleResult;
			var adjuster : StyleTune = c.getStyleTune().mide.clone();
			if(!c.isEnabled())  {
				adjuster = adjuster.sharpen(0.4);
			}

			else if(isPressing)  {
				cl = cl.offsetHLS(0, 0.08, 0);
			}

			else if(model.isRollOver())  {
				cl = cl.offsetHLS(-0.2, 0, 0.37);
				//cl = cl.offsetHLS(0, 0.08, 0);
			}
			style = new StyleResult(cl, adjuster);
			if(isPressing)  {
				style.cdark = style.cdark.changeAlpha(0);
			}
			var direction : Float = Math.PI / 2;
			var matrixB : IntRectangle = b.clone();
			b = b.clone();
			var placement : Int = getTabPlacement();
			var highlightBrush : SolidBrush = new SolidBrush(style.clight.offsetHLS(0, 0.14, 0.1));
			if(placement == JTabbedPane.TOP)  {
				direction = Math.PI / 2;
				b.height += Std.int(style.round * 2);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.width - style.round * 2 > 0)  {
					g.fillRectangle(highlightBrush, b.x + style.round, b.y + 1, b.width - style.round * 2, 1);
				}
			}

			else if(placement == JTabbedPane.BOTTOM)  {
				direction = -Math.PI / 2;
				b.height += Std.int(style.round * 2);
				b.y -=Std.int( style.round * 2);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.width - style.round * 2 > 0)  {
					g.fillRectangle(highlightBrush, b.x + style.round, b.y + b.height - 2, b.width - style.round * 2, 1);
				}
			}

			else if(placement == JTabbedPane.LEFT)  {
				direction = 0;
				b.width += Std.int(style.round * 2);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.height - style.round * 2 > 0)  {
					g.fillRectangle(highlightBrush, b.x + 1, b.y + style.round, 1, b.height - style.round * 2);
				}
			}

			else  {
				//right
				direction = Math.PI;
				b.width += Std.int(style.round * 2);
				b.x -= Std.int(style.round * 2);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.height - style.round * 2 > 0)  {
					g.fillRectangle(highlightBrush, b.x + b.width - 2, b.y + style.round, 1, b.height - style.round * 2);
				}
			}

		}
	}

	//---------------------
	public function initTab(owner : Component) : Void {
		this.owner = owner;
		panel = new Container();
		panel.setLayout(new BorderLayout());
		label = new JButton();
		label.setOpaque(false);
		label.setBackgroundDecorator(null);
		label.setMargin(new Insets());
		panel.append(label, BorderLayout.CENTER);
		button = createCloseButton();
		var bc : Container = new Container();
		bc.setLayout(new CenterLayout());
		bc.append(button);
		panel.append(bc, BorderLayout.EAST);
		label.setFocusable(false);
		button.setFocusable(false);
		margin = new Insets(0, 0, 0, 0);
		panel.setBackgroundDecorator(this);
		label.addEventListener(InteractiveEvent.STATE_CHANGED, __repaintPanel);
	}

	public function setComBounds(b : IntRectangle) : Void {
		panel.setComBounds(b);
		panel.validate();
		panel.repaint();
	}

	private function __repaintPanel(event : Event) : Void {
		panel.repaint();
	}

	public function setTabPlacement(tp : Int) : Void {
		placement = tp;
	}

	public function getTabPlacement() : Int {
		return placement;
	}

	private function createCloseButton() : AbstractButton {
		var button : AbstractButton = new JButton();
		button.setMargin(new Insets());
		button.setOpaque(false);
		button.setBackgroundDecorator(null);
		button.setIcon(new CloseIcon());
		return button;
	}

	public function setFont(font : ASFont) : Void {
		label.setFont(font);
	}

	public function setForeground(color : ASColor) : Void {
		label.setForeground(color);
	}

	public function setMargin(m : Insets) : Void {
		if(!margin.equals(m))  {
			panel.setBorder(new EmptyBorder(null, m));
			margin = m.clone();
		}
	}

	public function setEnabled(b : Bool) : Void {
		label.setEnabled(b);
		button.setEnabled(b);
	}

	public function getCloseButton() : Component {
		return button;
	}

	public function setVerticalAlignment(alignment : Int) : Void {
		label.setVerticalAlignment(alignment);
	}

	public function getTabComponent() : Component {
		return panel;
	}

	public function setHorizontalTextPosition(textPosition : Int) : Void {
		label.setHorizontalTextPosition(textPosition);
	}

	public function setTextAndIcon(text : String, icon : Icon) : Void {
		label.setText(text);
		label.setIcon(icon);
	}

	public function setIconTextGap(iconTextGap : Int) : Void {
		label.setIconTextGap(iconTextGap);
	}

	public function setSelected(b : Bool) : Void {
		label.setSelected(b);
	}

	public function setVerticalTextPosition(textPosition : Int) : Void {
		label.setVerticalTextPosition(textPosition);
	}

	public function setHorizontalAlignment(alignment : Int) : Void {
		label.setHorizontalAlignment(alignment);
	}

}

