/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * KeyStroke is a single key definition.
 * <p>
 * Thanks Romain for his Fever{@link http://fever.riaforge.org} accelerator framworks implementation, 
 * this is a simpler implementation study from his.
 * @author paling
 */
class KeyStroke implements KeyType{

	private var codeString:String;
	private var code:Int;
	
	/**
	 * Create a KeyStroke with string and key code.
	 */
	public function new(description:String, code:Int){
		this.codeString = description;
		this.code = code;
	}
	
	public function getDescription():String{
		return codeString;
	}
	
	public function getCodeSequence():Array<Dynamic>{
		return [code];
	}
	
	public function getCode():Int{
		return code;
	}
	
	public function toString():String{
		return "Keyboard[" + getDescription + "]";
	}
	
	public static var VK_0:KeyStroke = new KeyStroke("0", 48);
	public static var VK_1:KeyStroke = new KeyStroke("1", 49);
	public static var VK_2:KeyStroke = new KeyStroke("2", 50);
	public static var VK_3:KeyStroke = new KeyStroke("3", 51);
	public static var VK_4:KeyStroke = new KeyStroke("4", 52);
	public static var VK_5:KeyStroke = new KeyStroke("5", 53);
	public static var VK_6:KeyStroke = new KeyStroke("6", 54);
	public static var VK_7:KeyStroke = new KeyStroke("7", 55);
	public static var VK_8:KeyStroke = new KeyStroke("8", 56);
	public static var VK_9:KeyStroke = new KeyStroke("9", 57);
	
	public static var VK_A:KeyStroke = new KeyStroke("A", 65);
	public static var VK_B:KeyStroke = new KeyStroke("B", 66);
	public static var VK_C:KeyStroke = new KeyStroke("C", 67);
	public static var VK_D:KeyStroke = new KeyStroke("D", 68);
	public static var VK_E:KeyStroke = new KeyStroke("E", 69);
	public static var VK_F:KeyStroke = new KeyStroke("F", 70);
	public static var VK_G:KeyStroke = new KeyStroke("G", 71);
	public static var VK_H:KeyStroke = new KeyStroke("H", 72);
	public static var VK_I:KeyStroke = new KeyStroke("I", 73);
	public static var VK_J:KeyStroke = new KeyStroke("J", 74);
	public static var VK_K:KeyStroke = new KeyStroke("K", 75);
	public static var VK_L:KeyStroke = new KeyStroke("L", 76);
	public static var VK_M:KeyStroke = new KeyStroke("M", 77);
	public static var VK_N:KeyStroke = new KeyStroke("N", 78);
	public static var VK_O:KeyStroke = new KeyStroke("O", 79);
	public static var VK_P:KeyStroke = new KeyStroke("P", 80);
	public static var VK_Q:KeyStroke = new KeyStroke("Q", 81);
	public static var VK_R:KeyStroke = new KeyStroke("R", 82);
	public static var VK_S:KeyStroke = new KeyStroke("S", 83);
	public static var VK_T:KeyStroke = new KeyStroke("T", 84);
	public static var VK_U:KeyStroke = new KeyStroke("U", 85);
	public static var VK_V:KeyStroke = new KeyStroke("V", 86);
	public static var VK_W:KeyStroke = new KeyStroke("W", 87);
	public static var VK_X:KeyStroke = new KeyStroke("X", 88);
	public static var VK_Y:KeyStroke = new KeyStroke("Y", 89);
	public static var VK_Z:KeyStroke = new KeyStroke("Z", 90);
	
	public static var VK_F1:KeyStroke = new KeyStroke("F1", 112);
	public static var VK_F2:KeyStroke = new KeyStroke("F2", 113);
	public static var VK_F3:KeyStroke = new KeyStroke("F3", 114);
	public static var VK_F4:KeyStroke = new KeyStroke("F4", 115);
	public static var VK_F5:KeyStroke = new KeyStroke("F5", 116);
	public static var VK_F6:KeyStroke = new KeyStroke("F6", 117);
	public static var VK_F7:KeyStroke = new KeyStroke("F7", 118);
	public static var VK_F8:KeyStroke = new KeyStroke("F8", 119);
	public static var VK_F9:KeyStroke = new KeyStroke("F9", 120);
	public static var VK_F10:KeyStroke = new KeyStroke("F10", 121);
	public static var VK_F11:KeyStroke = new KeyStroke("F11", 122);
	public static var VK_F12:KeyStroke = new KeyStroke("F12", 123);
	public static var VK_F13:KeyStroke = new KeyStroke("F13", 124);
	public static var VK_F14:KeyStroke = new KeyStroke("F14", 125);
	public static var VK_F15:KeyStroke = new KeyStroke("F15", 126);
	
	public static var VK_NUMPAD_0:KeyStroke = new KeyStroke("Numpad_0", 96);
	public static var VK_NUMPAD_1:KeyStroke = new KeyStroke("Numpad_1", 97);
	public static var VK_NUMPAD_2:KeyStroke = new KeyStroke("Numpad_2", 98);
	public static var VK_NUMPAD_3:KeyStroke = new KeyStroke("Numpad_3", 99);
	public static var VK_NUMPAD_4:KeyStroke = new KeyStroke("Numpad_4", 100);
	public static var VK_NUMPAD_5:KeyStroke = new KeyStroke("Numpad_5", 101);
	public static var VK_NUMPAD_6:KeyStroke = new KeyStroke("Numpad_6", 102);
	public static var VK_NUMPAD_7:KeyStroke = new KeyStroke("Numpad_7", 103);
	public static var VK_NUMPAD_8:KeyStroke = new KeyStroke("Numpad_8", 104);
	public static var VK_NUMPAD_9:KeyStroke = new KeyStroke("Numpad_9", 105);
	public static var VK_NUMPAD_MULTIPLY:KeyStroke = new KeyStroke("Numpad_Multiply", 106); // *
	public static var VK_NUMPAD_ADD:KeyStroke = new KeyStroke("Numpad_Add", 107); // +
	public static var VK_NUMPAD_ENTER:KeyStroke = new KeyStroke("Numpad_Enter", 108); // Enter
	public static var VK_NUMPAD_SUBTRACT:KeyStroke = new KeyStroke("Numpad_Subtract", 109); // -
	public static var VK_NUMPAD_DECIMAL:KeyStroke = new KeyStroke("Numpad_Decimal", 110); // .
	public static var VK_NUMPAD_DIVIDE:KeyStroke = new KeyStroke("Numpad_Divide", 111); // /
	
	
	public static var VK_BACKSPACE:KeyStroke = new KeyStroke("Backspace", 8);//backspace
	public static var VK_TAB:KeyStroke = new KeyStroke("Tab", 9);//tab
	public static var VK_ENTER:KeyStroke = new KeyStroke("Enter", 13);//main ENTER
	public static var VK_SHIFT:KeyStroke = new KeyStroke("Shift", 16);//shift
	public static var VK_CONTROL:KeyStroke = new KeyStroke("Ctrl", 17);//ctrl
	public static var VK_ESCAPE:KeyStroke = new KeyStroke("Esc", 27);//esc
	public static var VK_SPACE:KeyStroke = new KeyStroke("Space", 32);//space
	
	public static var VK_CAPS_LOCK:KeyStroke = new KeyStroke("Cap", 20);//caps lock
	public static var VK_NUM_LOCK:KeyStroke = new KeyStroke("Num", 144);//num lock
	public static var VK_SCROLL_LOCK:KeyStroke = new KeyStroke("Scroll", 145);//scroll lock
	
	public static var VK_PAUSE:KeyStroke = new KeyStroke("Pause", 19);//pause / break
	public static var VK_PAGE_UP:KeyStroke = new KeyStroke("PageUp", 33);//page up
	public static var VK_PAGE_DOWN:KeyStroke = new KeyStroke("PageDown", 34);//page down
	public static var VK_END:KeyStroke = new KeyStroke("End", 35);//end
	public static var VK_HOME:KeyStroke = new KeyStroke("Home", 36);//home
	public static var VK_INSERT:KeyStroke = new KeyStroke("Insert", 45);//insert
	public static var VK_DELETE:KeyStroke = new KeyStroke("Delete", 46);//delete
	
	public static var VK_LEFT:KeyStroke = new KeyStroke("Left", 37);//left arrow
	public static var VK_UP:KeyStroke = new KeyStroke("Up", 38);//up arrow
	public static var VK_RIGHT:KeyStroke = new KeyStroke("Right", 39);//right arrow
	public static var VK_DOWN:KeyStroke = new KeyStroke("Down", 40);//down arrow
	
	public static var VK_WINDOWS:KeyStroke = new KeyStroke("Win", 91);//windows
	public static var VK_MENU:KeyStroke = new KeyStroke("Menu", 93);//menu
	
}