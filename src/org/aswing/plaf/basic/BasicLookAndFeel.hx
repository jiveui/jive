/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic;

import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import org.aswing.LookAndFeel;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.UIDefaults;
	import org.aswing.Insets;
	import org.aswing.plaf.ASColorUIResource;
	import org.aswing.plaf.ASFontUIResource;
	import org.aswing.plaf.UIStyleTune;
	import org.aswing.plaf.InsetsUIResource;
	import org.aswing.plaf.ArrayUIResource;
	import org.aswing.plaf.DefaultEmptyDecoraterResource;
	import org.aswing.plaf.basic.adjuster.PopupSliderThumbIcon;
import org.aswing.plaf.basic.border.EmptyBorderResource;
	import org.aswing.plaf.basic.tree.BasicExpandControl;
import org.aswing.resizer.DefaultResizer;
import org.aswing.resizer.ResizerController;
	/**
 * The art design named LastWing, work by lastdance. 
 * Note: All empty object should be undefined or an UIResource instance. 
 * Undefined/UIResource instance means not set, if it is null, means that user set it to be null, so LAF value will not be use. 
 * @author paling
 * @author lastdance
 */
class BasicLookAndFeel extends LookAndFeel {
	
	private  var NULL_COLOR:ASColor;
	private  var NULL_FONT:ASFont;

	/**
	 * Need to extends it to make a completed LAF and implements features.
	 */
	public function new(){
	NULL_COLOR=DefaultEmptyDecoraterResource.NULL_COLOR;
			NULL_FONT = DefaultEmptyDecoraterResource.NULL_FONT;
		
			}
	
	override public function getDefaults():UIDefaults{
		var table:UIDefaults  = new UIDefaults();

		initClassDefaults(table);
		initSystemColorDefaults(table);
		initSystemFontDefaults(table);
		initCommonUtils(table);
		initComponentDefaults(table);
		
		return table;
	}
	
	private function initClassDefaults(table:UIDefaults):Void{
		var uiDefaults:Array<Dynamic>= [
				// Basic ui is referenced in component class
				//if you created your ui, you must specified 
				//it in your LAF class like below commented.
			   /*"ButtonUI", org.aswing.plaf.basic.BasicButtonUI, 
			   "PanelUI", org.aswing.plaf.basic.BasicPanelUI, 
			   "ToggleButtonUI", org.aswing.plaf.basic.BasicToggleButtonUI,
			   "RadioButtonUI", org.aswing.plaf.basic.BasicRadioButtonUI,
			   "CheckBoxUI", org.aswing.plaf.basic.BasicCheckBoxUI, 
			   "ColorSwatchesUI", org.aswing.plaf.basic.BasicColorSwatchesUI,
			   "ColorMixerUI", org.aswing.plaf.basic.BasicColorMixerUI,
			   "ColorChooserUI", org.aswing.plaf.basic.BasicColorChooserUI,			   
			   "ScrollBarUI", org.aswing.plaf.basic.BasicScrollBarUI, 
			   "SeparatorUI", org.aswing.plaf.basic.BasicSeparatorUI,
			   "ViewportUI", org.aswing.plaf.basic.BasicViewportUI,
			   "ScrollPaneUI", org.aswing.plaf.basic.BasicScrollPaneUI, 
			   "LabelUI",org.aswing.plaf.basic.BasicLabelUI, 
			   "TextFieldUI",org.aswing.plaf.basic.BasicTextFieldUI, 
			   "TextAreaUI",org.aswing.plaf.basic.BasicTextAreaUI, 
			   "FrameUI",org.aswing.plaf.basic.BasicFrameUI, 
			   "ToolTipUI",org.aswing.plaf.basic.BasicToolTipUI, 
			   "ProgressBarUI", org.aswing.plaf.basic.BasicProgressBarUI,			   			   
			   "ListUI",org.aswing.plaf.basic.BasicListUI,		   			   
			   "ComboBoxUI",org.aswing.plaf.basic.BasicComboBoxUI,			   
			   "SliderUI",org.aswing.plaf.basic.BasicSliderUI,		   
			   "AdjusterUI",org.aswing.plaf.basic.BasicAdjusterUI,	   
			   "AccordionUI",org.aswing.plaf.basic.BasicAccordionUI,	   
			   "TabbedPaneUI",org.aswing.plaf.basic.BasicTabbedPaneUI,
			   "SplitPaneUI", org.aswing.plaf.basic.BasicSplitPaneUI,
			   "SpacerUI", org.aswing.plaf.basic.BasicSpacerUI,
			   "TableUI", org.aswing.plaf.basic.BasicTableUI, 
			   "TableHeaderUI", org.aswing.plaf.basic.BasicTableHeaderUI, 
			   "TreeUI", org.aswing.plaf.basic.BasicTreeUI, 
			   "StepperUI", org.aswing.plaf.basic.BasicStepperUI, 
			   "ToolBarUI", org.aswing.plaf.basic.BasicToolBarUI*/
		   ];
		table.putDefaults(uiDefaults);
	}
	
	private function initSystemColorDefaults(table:UIDefaults):Void{
		var defaultSystemColors:Array<Dynamic>= [
			"window", 0xe6e6e6,  //window panel background color
			"windowText", 0xFFFFFE, /* ??? */
			"menu", 0xeaeaea, /* Background color for menus */
			"menuText", 0x5d5d5d, /* Text color for menus  */
			"control", 0x000000, /* Default color for background in controls */
			"controlMide", 0x2fb7ea, /* Default color for thumb in controls */
			"controlText", 0x4d4d4d, /* Default color for text in controls */				
			"selectionForeground", 0xFFFFFF 
		];
		
		for(i in 0...defaultSystemColors.length){
			table.set(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
		}
		table.set("selectionBackground", new ASColorUIResource(0x93b858, 0.9));
		table.set("focusInner", new ASColorUIResource(0x40FF40, 0.3));
		table.set("focusOutter", new ASColorUIResource(0x40FF40, 0.4));
	}
	
	private function initSystemFontDefaults(table:UIDefaults):Void{
		var defaultSystemFonts:Array<Dynamic>= [
			"systemFont", new ASFontUIResource("Arial", 12), 
			"menuFont", new ASFontUIResource("Arial", 12), 
			"controlFont", new ASFontUIResource("Arial", 12, false), 
			"windowFont", new ASFontUIResource("Arial", 12, true)
		];
		table.putDefaults(defaultSystemFonts);
	}
	
	private function initCommonUtils(table:UIDefaults):Void{
		ResizerController.setDefaultResizerClass(DefaultResizer);
	 
		var arrowColors:Array<Dynamic>= [
			"resizeArrow", new ASColorUIResource(0x4dc1d0),
			"resizeArrowLight", new ASColorUIResource(0xA2DFE6),
			"resizeArrowDark", new ASColorUIResource(0x2A95A1),
		];
		table.putDefaults(arrowColors);
		
		var cursors:Array<Dynamic>= [
			"System.hResizeCursor", org.aswing.plaf.basic.cursor.H_ResizeCursor,
			"System.vResizeCursor", org.aswing.plaf.basic.cursor.V_ResizeCursor,
			"System.hvResizeCursor", org.aswing.plaf.basic.cursor.HV_ResizeCursor,
			"System.hMoveCursor", org.aswing.plaf.basic.cursor.H_ResizeCursor,
			"System.vMoveCursor", org.aswing.plaf.basic.cursor.V_ResizeCursor,
			"System.hvMoveCursor", org.aswing.plaf.basic.cursor.HV_ResizeCursor	
		];
		table.putDefaults(cursors);
	}
	
	private function initComponentDefaults(table:UIDefaults):Void{
		var buttonBG:ASColorUIResource = new ASColorUIResource(0x3e9cd5);
		var textBG:ASColorUIResource = new ASColorUIResource(0xfafafa);
		// *** Button
		var f :Array<BitmapFilter>;
		f= new Array<BitmapFilter>();
		f.push(new  DropShadowFilter(1, 45, 0, 0.3, 1, 1, 1, 1));
		var comDefaults:Array<Dynamic>= [
			"Button.background", buttonBG,
			"Button.foreground", new ASColorUIResource(0xFFFFFE),
			"Button.mideground", table.get("controlMide"),
			"Button.colorAdjust", new UIStyleTune(0.18, -0.02, 0.34, 0.22, 5), 
			"Button.opaque", true,  
			"Button.focusable", true,  
			"Button.font", table.getFont("controlFont"),
			"Button.bg", org.aswing.plaf.basic.background.ButtonBackground,
			"Button.margin", new InsetsUIResource(2, 3, 5, 3), 
			"Button.textShiftOffset", 0 
			,"Button.textFilters", f
			 
		];
		table.putDefaults(comDefaults);
		f= new Array<BitmapFilter>();
		f.push(new  DropShadowFilter(1, 45, 0, 0.0, 1, 1, 1, 1));
		// *** LabelButton
		comDefaults = [
			"LabelButton.background", buttonBG,
			"LabelButton.foreground", new ASColorUIResource(0x005617), 
			"LabelButton.mideground", table.get("controlMide"), 
			"LabelButton.colorAdjust", new UIStyleTune(0.26, 0.05, 0.20, 0.20), 
			"LabelButton.opaque", false,  
			"LabelButton.focusable", true,  
			"LabelButton.font", table.getFont("controlFont"),
			"LabelButton.margin", new InsetsUIResource(0, 0, 0, 0), 
			"LabelButton.textShiftOffset", 0 ,
		    "LabelButton.textFilters", f
		];
		table.putDefaults(comDefaults);
		
		// *** Panel
		comDefaults = [
			"Panel.background", table.get("window"),
			"Panel.foreground", table.get("windowText"),
			"Panel.mideground", table.get("controlMide"), 
			"Panel.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"Panel.opaque", false,  
			"Panel.focusable", false, 
			"Panel.bg", org.aswing.plaf.basic.background.PanelBackground, 
			"Panel.font", table.getFont("windowFont")
		];
		table.putDefaults(comDefaults);
		f= new Array<BitmapFilter>();
		f.push(new  DropShadowFilter(1, 45, 0, 0.3, 1, 1, 1, 1));
		// *** ToggleButton
		comDefaults = [
			"ToggleButton.background", buttonBG,
			"ToggleButton.foreground", new ASColorUIResource(0xFFFFFE), 
			"ToggleButton.mideground", table.get("controlMide"), 
			"ToggleButton.colorAdjust", new UIStyleTune(0.18, -0.02, 0.34, 0.22, 5), 
			"ToggleButton.opaque", true, 
			"ToggleButton.focusable", true, 
			"ToggleButton.font", table.getFont("controlFont"),
			"ToggleButton.bg", org.aswing.plaf.basic.background.ToggleButtonBackground,
			"ToggleButton.margin", new InsetsUIResource(2, 3, 5, 3), 
			"ToggleButton.textShiftOffset", 1 
			,"ToggleButton.textFilters", f
			 
		];
		table.putDefaults(comDefaults);
		
		// *** RadioButton
		comDefaults = [
			"RadioButton.background", new ASColorUIResource(0xe1e5e5),
			"RadioButton.foreground", table.get("controlText"), 
			"RadioButton.mideground", new ASColorUIResource(0x39afff), 
			"RadioButton.colorAdjust", new UIStyleTune(0.8, 0.01, 0.4, 0.30, 0, new UIStyleTune(0.4, 0.1, 0.1, 0.00)), 
			"RadioButton.opaque", false, 
			"RadioButton.focusable", true, 
			"RadioButton.font", table.getFont("controlFont"),
			"RadioButton.icon", org.aswing.plaf.basic.icon.RadioButtonIcon,
			"RadioButton.margin", new InsetsUIResource(0, 0, 0, 0), 
			"RadioButton.textShiftOffset", 0, 
			"RadioButton.textFilters", []
		];
		table.putDefaults(comDefaults);
		// *** TextField
		comDefaults = [
			"TextField.background", textBG,
			"TextField.foreground", table.get("controlText"), 
			"TextField.mideground", new ASColorUIResource(0x89bb00), 
			"TextField.colorAdjust", new UIStyleTune(0.0, -0.30, 0.0, 0.30, 3), 
			"TextField.opaque", true, 
			"TextField.focusable", true, 
			"TextField.font", table.getFont("controlFont"),
			"TextField.bg", org.aswing.plaf.basic.background.TextComponentBackBround,
			"TextField.border", new EmptyBorderResource(null, new Insets(1, 3, 2, 3))
		];
		table.putDefaults(comDefaults);
		// *** CheckBox
		comDefaults = [
			"CheckBox.background", new ASColorUIResource(0xe1e5e5), ////0xd0f8fb
			"CheckBox.foreground", table.get("controlText"), 
			"CheckBox.mideground", new ASColorUIResource(0x39afff), 
			"CheckBox.colorAdjust", new UIStyleTune(0.8, 0.01, 0.4, 0.30, 2, new UIStyleTune(0.5, -0.2, 0.5, 0.70)), 
			"CheckBox.opaque", false, 
			"CheckBox.focusable", true, 
			"CheckBox.font", table.getFont("controlFont"),
			"CheckBox.icon", org.aswing.plaf.basic.icon.CheckBoxIcon,
			"CheckBox.margin", new InsetsUIResource(0, 0, 0, 0), 
			"CheckBox.textShiftOffset", 0, 
			"CheckBox.textFilters", []
		];
		table.putDefaults(comDefaults);
				
		// *** Separator
		comDefaults = [
			"Separator.background", new ASColorUIResource(0x358375, 0.3),
			"Separator.foreground", NULL_COLOR, 
			"Separator.mideground", NULL_COLOR, 
			"Separator.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"Separator.opaque", false, 
			"Separator.focusable", false 
		];
		table.putDefaults(comDefaults);		
		
		// *** ScrollBar
		comDefaults = [
			"ScrollBar.background", new ASColorUIResource(0xa8a8a8, 0.3),
			"ScrollBar.foreground", table.get("controlText"), 
			"ScrollBar.mideground", new ASColorUIResource(0xe7e7e7, 0.8), 
			"ScrollBar.colorAdjust", new UIStyleTune(0.18, 0.08, 0.20, 0.50, 2, new UIStyleTune(0.08, -0.3, 0.08, 0.20, 2)), 
			"ScrollBar.opaque", true, 
			"ScrollBar.focusable", true, 
			"ScrollBar.barWidth", 14, 
			"ScrollBar.minimumThumbLength", 24, 
			"ScrollBar.font", table.getFont("controlFont"),
			"ScrollBar.bg", org.aswing.plaf.basic.background.ScrollBarBackground,
			"ScrollBar.thumbDecorator", org.aswing.plaf.basic.background.ScrollBarThumb
		];
		table.putDefaults(comDefaults);
		
		// *** ScrollPane
		comDefaults = [
			"ScrollPane.background", table.get("window"),
			"ScrollPane.foreground", table.get("windowText"), 
			"ScrollPane.mideground", table.get("controlMide"), 
			"ScrollPane.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"ScrollPane.opaque", false,  
			"ScrollPane.focusable", false, 
			"ScrollPane.font", table.getFont("windowFont")
		];
		table.putDefaults(comDefaults);
		
		// *** ProgressBar
		comDefaults = [
			"ProgressBar.background", new ASColorUIResource(0xb5b5b5, 0.3),
			"ProgressBar.foreground", table.get("windowText"), 
			"ProgressBar.mideground", new ASColorUIResource(0xcef65f), 
			"ProgressBar.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.50, 4, new UIStyleTune(0.34, -0.4, 0.01, 0.50, 4)), 
			"ProgressBar.opaque", true, 
			"ProgressBar.focusable", false,	
			"ProgressBar.barWidth", 11, //means the size of bar
			"ProgressBar.font", new ASFontUIResource("Tahoma", 9), 
			"ProgressBar.bg", org.aswing.plaf.basic.background.ProgressBarBackground, 
			"ProgressBar.fg", org.aswing.plaf.basic.background.ProgressBarIcon, 
			"ProgressBar.progressColor", new ASColorUIResource(0x3366CC), 
			"ProgressBar.indeterminateDelay", 40
		];
		table.putDefaults(comDefaults);
		
		// *** Viewport
		comDefaults = [
			"Viewport.background", table.get("window"),
			"Viewport.foreground", table.get("windowText"), 
			"Viewport.mideground", table.get("controlMide"), 
			"Viewport.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"Viewport.opaque", false, 
			"Viewport.focusable", true, 
			"Viewport.font", table.getFont("windowFont")
		];
		table.putDefaults(comDefaults);
		
	   // *** Label
		comDefaults = [
			"Label.background", table.get("control"),
			"Label.foreground", table.get("controlText"), 
			"Label.mideground", table.get("controlMide"), 
			"Label.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"Label.opaque", false, 
			"Label.focusable", false, 
			"Label.font", table.getFont("controlFont")
		];
		table.putDefaults(comDefaults);
		
	   
		
	   // *** TextArea
		comDefaults = [
			"TextArea.background", textBG,
			"TextArea.foreground", table.get("controlText"), 
			"TextArea.mideground",  new ASColorUIResource(0x89bb00), 
			"TextArea.colorAdjust", new UIStyleTune(0.0, -0.30, 0.0, 0.30, 3), 
			"TextArea.opaque", true, 
			"TextArea.focusable", true, 
			"TextArea.font", table.getFont("controlFont"),
			"TextArea.bg", org.aswing.plaf.basic.background.TextComponentBackBround,
			"TextArea.border", new EmptyBorderResource(null, new Insets(1, 3, 2, 3))
		];
		table.putDefaults(comDefaults);
		
		// *** Frame
		comDefaults = [
			"Frame.background", new ASColorUIResource(0xe6e6e6),
			"Frame.foreground", new ASColorUIResource(0x666666), 
			"Frame.mideground", new ASColorUIResource(0xaad51a), 
			"Frame.colorAdjust", new UIStyleTune(0.10, 0.0, 0.0, 0.30, 10, new UIStyleTune(0.10, 0.0, 0.0, 0.60, 10)), 
			"Frame.opaque", true, 
			"Frame.focusable", true, 
			"Frame.dragDirectly", true, 
			"Frame.resizeArrow", new ASColorUIResource(0x2d6d89), 
			"Frame.resizeArrowLight", new ASColorUIResource(0xE2E2DE), 
			"Frame.resizeArrowDark",  new ASColorUIResource(0x2e6d8a), 		
			"Frame.resizer", org.aswing.resizer.DefaultResizer, 
			"Frame.font", table.get("windowFont"), 
			"Frame.resizerMargin", new InsetsUIResource(2, 1, 6, 6), 
			//"Frame.backgroundMargin", new InsetsUIResource(2, 4, 8, 8), 
			"Frame.bg", org.aswing.plaf.basic.background.FrameBackground, 
			"Frame.border", new EmptyBorderResource(null, new Insets(0, 6, 12, 12)), 
			"Frame.icon", org.aswing.plaf.basic.icon.TitleIcon, 
			"Frame.iconifiedIcon", org.aswing.plaf.basic.icon.FrameIconifiedIcon, 
			"Frame.normalIcon", org.aswing.plaf.basic.icon.FrameNormalIcon, 
			"Frame.maximizeIcon", org.aswing.plaf.basic.icon.FrameMaximizeIcon, 
			"Frame.closeIcon", org.aswing.plaf.basic.icon.FrameCloseIcon
		];
		table.putDefaults(comDefaults);		
		
		// *** FrameTitleBar
		comDefaults = [
			"FrameTitleBar.background", new ASColorUIResource(0xc4e066),
			"FrameTitleBar.foreground", new ASColorUIResource(0x0084ad), 
			"FrameTitleBar.mideground", new ASColorUIResource(0xbedb5d), 
			"FrameTitleBar.colorAdjust", new UIStyleTune(0.24, 0.01, 0.18, 0.50, 0, new UIStyleTune(0.2, -0.28, 0.08, 0.10, 1)), 
			"FrameTitleBar.opaque", true, 
			"FrameTitleBar.focusable", false, 
			"FrameTitleBar.titleBarHeight", 25, 
			"FrameTitleBar.buttonGap", 2, 
			"FrameTitleBar.font", table.get("windowFont"), 
			"FrameTitleBar.border", new EmptyBorderResource(null, new Insets(7, 0, 0, 0)), 
			//"FrameTitleBar.bg", org.aswing.plaf.basic.frame.BasicFrameTitleBarTitleBarBG, 
			"FrameTitleBar.icon", org.aswing.plaf.basic.icon.TitleIcon, 
			"FrameTitleBar.iconifiedIcon", org.aswing.plaf.basic.icon.FrameIconifiedIcon, 
			"FrameTitleBar.normalIcon", org.aswing.plaf.basic.icon.FrameNormalIcon, 
			"FrameTitleBar.maximizeIcon", org.aswing.plaf.basic.icon.FrameMaximizeIcon, 
			"FrameTitleBar.closeIcon", org.aswing.plaf.basic.icon.FrameCloseIcon
		];
		table.putDefaults(comDefaults);
		f= new Array<BitmapFilter>();
		f.push(new  DropShadowFilter(4.0, 45, 0, 0.3, 2.0, 2.0, 0.5));
		// *** ToolTip
		comDefaults = [
			"ToolTip.background", new ASColorUIResource(0xecfcfc), 
			"ToolTip.foreground", new ASColorUIResource(0x003344), 
			"ToolTip.mideground", new ASColorUIResource(0x2d6883), 
			"ToolTip.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20, 2), 
			"ToolTip.opaque", true, 
			"ToolTip.focusable", false, 
			"ToolTip.font", table.getFont("controlFont"), 
			"ToolTip.filters",f,
			"ToolTip.bg", org.aswing.plaf.basic.background.ToolTipBackground, 
			"ToolTip.border", new EmptyBorderResource(null, new Insets(1, 3, 1, 3))
		];
		table.putDefaults(comDefaults);
		
		// *** List
		comDefaults = [
			"List.font", table.getFont("controlFont"),
			"List.background", new ASColorUIResource(0x33859a, 0),
			"List.foreground", table.get("controlText"), 
			"List.mideground", new ASColorUIResource(0x33869a), 
			"List.colorAdjust", new UIStyleTune(0.08, 0.05, 0.20, 0.20, 0), 
			"List.opaque", false, 
			"List.focusable", true, 
			"List.bg", org.aswing.plaf.basic.background.ListBackground, 
		    "List.selectionBackground", table.get("selectionBackground"),
		    "List.selectionForeground", table.get("selectionForeground")
		];
		table.putDefaults(comDefaults);
		
		// *** SplitPane
		comDefaults = [
			"SplitPane.background", new ASColorUIResource(0x26627c), 
			"SplitPane.foreground", new ASColorUIResource(0x50aeda), 
			"SplitPane.mideground", table.get("controlMide"), 
			"SplitPane.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"SplitPane.opaque", false, 
			"SplitPane.focusable", true, 
			"SplitPane.defaultDividerSize", 10, 
			"SplitPane.font", table.getFont("windowFont"), 
			"SplitPane.border", null, 
			"SplitPane.presentDragColor", new ASColorUIResource(0x4595b8, 0.4)
		];
		table.putDefaults(comDefaults);	
		
		// *** Spacer
		comDefaults = [
			"Spacer.background", table.get("window"),
			"Spacer.foreground", table.get("window"), 
			"Spacer.mideground", table.get("controlMide"), 
			"Spacer.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"Spacer.opaque", false,
			"Spacer.focusable", false
		];
		table.putDefaults(comDefaults);
		
		// *** ComboBox
		comDefaults = [
			"ComboBox.font", table.getFont("controlFont"),
			"ComboBox.background", textBG, 
			"ComboBox.foreground", table.get("controlText"), 
			"ComboBox.mideground", new ASColorUIResource(0x89bb00), 
			"ComboBox.colorAdjust", new UIStyleTune(0.0, -0.30, 0.0, 0.32, 3, new UIStyleTune(0.04, 0.05, 0.20, 0.1)), 
			"ComboBox.opaque", true, 
			"ComboBox.focusable", true, 
			"ComboBox.popupBorder", org.aswing.plaf.basic.border.ComboBoxPopupBorder, 
			"ComboBox.bg", org.aswing.plaf.basic.background.InputBackground, 
			"ComboBox.border", new EmptyBorderResource(null, new Insets(1, 3, 2, 3))
		];
		table.putDefaults(comDefaults);
		
		// *** Slider
		comDefaults = [
			"Slider.font", table.getFont("controlFont"),
			"Slider.background", new ASColorUIResource(0x6fe8f9, 0.34),
			"Slider.foreground", table.get("controlText"), 
			"Slider.mideground", table.get("controlMide"), 
			"Slider.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.50, 6, new UIStyleTune(0.2, 0.00, 0.4, 0.00, 0)), 
			"Slider.opaque", false,  
			"Slider.focusable", true, 
			"Slider.thumbIcon", org.aswing.plaf.basic.icon.SliderThumbIcon
		];
		table.putDefaults(comDefaults);
		
		// *** Adjuster
		comDefaults = [
			"Adjuster.background", textBG,
			"Adjuster.foreground", table.get("controlText"), 
			"Adjuster.mideground", new ASColorUIResource(0x89bb00), 
			"Adjuster.colorAdjust", new UIStyleTune(0.0, -0.30, 0.0, 0.32, 3, new UIStyleTune(0.04, 0.05, 0.20, 0.1)), 
			"Adjuster.opaque", true, 
			"Adjuster.focusable", true, 
			"Adjuster.font", table.getFont("controlFont"), 
			"Adjuster.thumbIcon", org.aswing.plaf.basic.adjuster.PopupSliderThumbIcon,
			"Adjuster.bg", org.aswing.plaf.basic.background.InputBackground, 
			"Adjuster.border", new EmptyBorderResource(null, new Insets(1, 3, 2, 3))
		];
		table.putDefaults(comDefaults);
	
		// *** Stepper
		comDefaults = [
			"Stepper.font", table.getFont("controlFont"),
			"Stepper.background", textBG, 
			"Stepper.foreground", table.get("controlText"), 
			"Stepper.mideground", new ASColorUIResource(0x89bb00), 
			"Stepper.colorAdjust", new UIStyleTune(0.0, -0.30, 0.0, 0.32, 3, new UIStyleTune(0.04, 0.05, 0.20, 0.1)), 
			"Stepper.opaque", true, 
			"Stepper.focusable", true, 
			"Stepper.bg", org.aswing.plaf.basic.background.InputBackground, 
			"Stepper.border", new EmptyBorderResource(null, new Insets(1, 3, 2, 3))
		];
		table.putDefaults(comDefaults);
		
		// *** ColorSwatches
		comDefaults = [
			"ColorSwatches.background", new ASColorUIResource(0xEEEEEE),
			"ColorSwatches.foreground", table.get("controlText"), 
			"ColorSwatches.mideground", table.get("controlMide"), 
			"ColorSwatches.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"ColorSwatches.opaque", false, 
			"ColorSwatches.focusable", false, 
			"ColorSwatches.font", table.getFont("controlFont"), 
			"ColorSwatches.border", null];
		table.putDefaults(comDefaults);
		
		// *** ColorMixer
		comDefaults = [
			"ColorMixer.background", new ASColorUIResource(0xEEEEEE),
			"ColorMixer.foreground", table.get("controlText"), 
			"ColorMixer.mideground", table.get("controlMide"), 
			"ColorMixer.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"ColorMixer.opaque", false,  
			"ColorMixer.focusable", false,  
			"ColorMixer.font", table.getFont("controlFont"),
			"ColorMixer.border", null];
		table.putDefaults(comDefaults);
		
		// *** ColorChooser
		comDefaults = [
			"ColorChooser.background", table.get("window"),
			"ColorChooser.foreground", table.get("controlText"), 
			"ColorChooser.mideground", table.get("controlMide"), 
			"ColorChooser.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"ColorChooser.opaque", false,  
			"ColorChooser.focusable", false,  
			"ColorChooser.font", table.getFont("controlFont"),
			"ColorChooser.border", org.aswing.plaf.basic.border.ColorChooserBorder
		];
		table.putDefaults(comDefaults);		
		
		// *** Accordion
		comDefaults = [
			"Accordion.font", table.getFont("controlFont"),
			"Accordion.background", table.get("window"),
			"Accordion.foreground", new ASColorUIResource(0xFFFFFE), 
			"Accordion.mideground", table.get("controlMide"), 
			"Accordion.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"Accordion.opaque", false,  
			"Accordion.focusable", true,
			"Accordion.motionSpeed", 50, 
			"Accordion.tabMargin", new InsetsUIResource(2, 3, 3, 2)
		];
		table.putDefaults(comDefaults);
		
	   // *** JTabbedPane
		comDefaults = [
			"TabbedPane.background", table.get("window"), //new ASColorUIResource(0xE7E7E5),
			"TabbedPane.foreground", table.get("controlText"), 
			"TabbedPane.mideground", new ASColorUIResource(0xcacbcb), 
			"TabbedPane.colorAdjust", new UIStyleTune(0.01, -0.14, 0.01, 0.50, 4, new UIStyleTune(0.05, -0.23, 0.01, 0.50, 4)), 
			"TabbedPane.opaque", false,  
			"TabbedPane.focusable", true,  
			"TabbedPane.arrowShadowColor", new ASColorUIResource(0x000000),
			"TabbedPane.arrowLightColor", new ASColorUIResource(0x444444),
			"TabbedPane.font", table.getFont("controlFont"),
			"TabbedPane.tabMargin", new InsetsUIResource(3, 8, 2, 8),
			"TabbedPane.contentMargin", new InsetsUIResource(10, 2, 2, 2), 
			"TabbedPane.selectedTabExpandInsets", new InsetsUIResource(0, 0, 0, 0), 
			//indicate the insets of border bar
			"TabbedPane.tabBorderInsets", new InsetsUIResource(0, 0, 0, 0), //new InsetsUIResource(0, 18, 0, 18),
			"TabbedPane.contentRoundLineThickness", 0, 
			"TabbedPane.tabGap", 2, 
			"TabbedPane.topBlankSpace", 0, 
			"TabbedPane.maxTabWidth", 1000];
		table.putDefaults(comDefaults);
		
	   // *** JClosableTabbedPane
		comDefaults = [
			"ClosableTabbedPane.background", new ASColorUIResource(0xE7E7E5),
			"ClosableTabbedPane.foreground", table.get("controlText"), 
			"ClosableTabbedPane.mideground", new ASColorUIResource(0x4dc1d0), 
			"ClosableTabbedPane.colorAdjust", new UIStyleTune(0.01, -0.24, 0.01, 0.50, 4), 
			"ClosableTabbedPane.opaque", false,  
			"ClosableTabbedPane.focusable", true,  
			"ClosableTabbedPane.shadow", new ASColorUIResource(0x888888),		
			"ClosableTabbedPane.darkShadow", new ASColorUIResource(0x444444),		
			"ClosableTabbedPane.light", table.getColor("controlHighlight"),	   
	   		"ClosableTabbedPane.highlight", new ASColorUIResource(0xFFFFFF),
			"ClosableTabbedPane.arrowShadowColor", new ASColorUIResource(0x000000),
			"ClosableTabbedPane.arrowLightColor", new ASColorUIResource(0x444444),
			"ClosableTabbedPane.font", table.getFont("controlFont"),
			"ClosableTabbedPane.tabMargin", new InsetsUIResource(2, 3, 1, 3),
			"ClosableTabbedPane.contentMargin", new InsetsUIResource(8, 2, 2, 2), 
			"ClosableTabbedPane.contentRoundLineThickness", 2, 
			"ClosableTabbedPane.topBlankSpace", 4, 
			"ClosableTabbedPane.maxTabWidth", 1000];
		table.putDefaults(comDefaults);
		
		 // *** Table
		comDefaults = [
			"Table.background", new ASColorUIResource(0x308fa1, 0.0),
			"Table.foreground", table.get("controlText"), 
			"Table.mideground", new ASColorUIResource(0xebebeb), 
			"Table.colorAdjust", new UIStyleTune(0.10, -0.2, 0.10, 0.20, 0), 
			"Table.opaque", true, 
			"Table.focusable", true, 
			"Table.font", table.getFont("controlFont"),
		    "Table.selectionBackground", table.get("selectionBackground"),
		    "Table.selectionForeground", table.get("selectionForeground"), 
			"Table.gridColor", new ASColorUIResource(0xd6d6d6), 
			"Table.bg", org.aswing.plaf.basic.background.TableBackground,
			"Table.border", new EmptyBorderResource(null, new Insets(2, 2, 2, 2))
		];
		table.putDefaults(comDefaults);
		
		 // *** TableHeader
		comDefaults = [
			"TableHeader.font", table.getFont("controlFont"), 
			"TableHeader.background", new ASColorUIResource(0xdbdbdb),
			"TableHeader.foreground", table.get("controlText"), 
			"TableHeader.mideground", new ASColorUIResource(0x9d9d9d), 
			"TableHeader.colorAdjust", new UIStyleTune(0.06, 0.2, 0.10, 0.5, 0, new UIStyleTune(0.04, 0.05, 0.20, 0.1)), 
			"TableHeader.opaque", true, 
			"TableHeader.focusable", true, 
			"TableHeader.gridColor", new ASColorUIResource(0xd6d6d6),
			"TableHeader.bg", org.aswing.plaf.basic.background.TableHeaderBackground, 
			"TableHeader.border", null, 
			"TableHeader.cellBorder", org.aswing.plaf.basic.border.TableHeaderCellBorder, 
			"TableHeader.sortableCellBorder", org.aswing.plaf.basic.border.TableHeaderCellBorder
		];
		table.putDefaults(comDefaults);
		
		 // *** Tree
		comDefaults = [
			"Tree.background", new ASColorUIResource(0x33859a, 0),
			"Tree.foreground", table.get("controlText"), 
			"Tree.mideground", table.get("controlMide"), 
			"Tree.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"Tree.opaque", false,  
			"Tree.focusable", true,
			"Tree.font", table.getFont("controlFont"),
		    "Tree.selectionBackground", table.get("selectionBackground"),
		    "Tree.selectionForeground", table.get("selectionForeground"), 
			"Tree.leafIcon", org.aswing.tree.TreeLeafIcon, 
			"Tree.folderExpandedIcon", org.aswing.tree.TreeFolderIcon, 
			"Tree.folderCollapsedIcon", org.aswing.tree.TreeFolderIcon, 
			"Tree.leftChildIndent", 10, 
			"Tree.rightChildIndent", 0, 
			"Tree.rowHeight", 16, 
			"Tree.expandControl", org.aswing.plaf.basic.tree.BasicExpandControl, 
			"Tree.border", null];
		table.putDefaults(comDefaults);
		
		 // *** ToolBar
		comDefaults = [
			"ToolBar.background", new ASColorUIResource(0xA5CE1C),
			"ToolBar.foreground", table.get("windowText"), 
			"ToolBar.mideground", table.get("controlMide"), 
			"ToolBar.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
			"ToolBar.opaque", true, 
			"ToolBar.focusable", false 
		];
		table.putDefaults(comDefaults);
	    
	     // *** MenuItem
	    comDefaults = [
		    "MenuItem.background", table.get("menu"),
		    "MenuItem.foreground", table.get("menuText"), 
			"MenuItem.mideground", table.get("controlMide"), 
			"MenuItem.colorAdjust", new UIStyleTune(0.0, 0.0, 0.0, 0.0, 2), 
	    	"MenuItem.opaque", false, 
	    	"MenuItem.focusable", false, 
	        "MenuItem.font", table.getFont("menuFont"),
		    "MenuItem.selectionBackground", table.get("selectionBackground"), 
		    "MenuItem.selectionForeground", table.get("selectionForeground"),
		    "MenuItem.disabledForeground", new ASColorUIResource(0x888888),
		    "MenuItem.acceleratorFont", table.getFont("menuFont"),
		    "MenuItem.acceleratorForeground", table.get("menuText"),
		    "MenuItem.acceleratorSelectionForeground", table.get("menu"),
	    	"MenuItem.border", null,
	    	"MenuItem.arrowIcon", org.aswing.plaf.basic.icon.MenuItemArrowIcon,
	    	"MenuItem.checkIcon", org.aswing.plaf.basic.icon.MenuItemCheckIcon,
			"MenuItem.margin", new InsetsUIResource(0, 0, 0, 0)
	    ];
	    table.putDefaults(comDefaults);
	    
	     // *** CheckBoxMenuItem
	    comDefaults = [
		    "CheckBoxMenuItem.background", table.get("menu"),
		    "CheckBoxMenuItem.foreground", table.get("menuText"), 
			"CheckBoxMenuItem.mideground", new ASColorUIResource(0x5d5d5d), 
			"CheckBoxMenuItem.colorAdjust", new UIStyleTune(0.0, 0.0, 0.0, 0.0, 2), 
	    	"CheckBoxMenuItem.opaque", false,  
	    	"CheckBoxMenuItem.focusable", false,
	        "CheckBoxMenuItem.font", table.getFont("menuFont"),
		    "CheckBoxMenuItem.selectionBackground", table.get("selectionBackground"), 
		    "CheckBoxMenuItem.selectionForeground", table.get("selectionForeground"),
		    "CheckBoxMenuItem.disabledForeground", new ASColorUIResource(0x888888),
		    "CheckBoxMenuItem.acceleratorFont", table.getFont("menuFont"),
		    "CheckBoxMenuItem.acceleratorForeground", table.get("menuText"),
		    "CheckBoxMenuItem.acceleratorSelectionForeground", table.get("menu"),
	    	"CheckBoxMenuItem.border", null,
	    	"CheckBoxMenuItem.arrowIcon", org.aswing.plaf.basic.icon.MenuItemArrowIcon,
	    	"CheckBoxMenuItem.checkIcon", org.aswing.plaf.basic.icon.CheckBoxMenuItemCheckIcon,
			"CheckBoxMenuItem.margin", new InsetsUIResource(0, 0, 0, 0)
	    ];
	    table.putDefaults(comDefaults);
	    
	     // *** RadioButtonMenuItem
	    comDefaults = [
		    "RadioButtonMenuItem.background", table.get("menu"),
		    "RadioButtonMenuItem.foreground", table.get("menuText"), 
			"RadioButtonMenuItem.mideground", new ASColorUIResource(0x5d5d5d), 
			"RadioButtonMenuItem.colorAdjust", new UIStyleTune(0.0, 0.0, 0.0, 0.0, 2), 
	    	"RadioButtonMenuItem.opaque", false,  
	    	"RadioButtonMenuItem.focusable", false,
	        "RadioButtonMenuItem.font", table.getFont("menuFont"),
		    "RadioButtonMenuItem.selectionBackground", table.get("selectionBackground"), 
		    "RadioButtonMenuItem.selectionForeground", table.get("selectionForeground"),
		    "RadioButtonMenuItem.disabledForeground", new ASColorUIResource(0x888888),
		    "RadioButtonMenuItem.acceleratorFont", table.getFont("menuFont"),
		    "RadioButtonMenuItem.acceleratorForeground", table.get("menuText"),
		    "RadioButtonMenuItem.acceleratorSelectionForeground", table.get("menu"),
	    	"RadioButtonMenuItem.border", null,
	    	"RadioButtonMenuItem.arrowIcon", org.aswing.plaf.basic.icon.MenuItemArrowIcon,
	    	"RadioButtonMenuItem.checkIcon", org.aswing.plaf.basic.icon.RadioButtonMenuItemCheckIcon,
			"RadioButtonMenuItem.margin", new InsetsUIResource(0, 0, 0, 0)
	    ];
	    table.putDefaults(comDefaults);
	    
	     // *** Menu
	    comDefaults = [
		    "Menu.background", table.get("menu"),
		    "Menu.foreground", table.get("menuText"), 
			"Menu.mideground", new ASColorUIResource(0x5d5d5d), 
			"Menu.colorAdjust", new UIStyleTune(0.0, 0.0, 0.0, 0.0, 2), 
	    	"Menu.opaque", false, 
	    	"Menu.focusable", false, 
	        "Menu.font", table.getFont("menuFont"), 
		    "Menu.selectionBackground", table.get("selectionBackground"), 
		    "Menu.selectionForeground", table.get("selectionForeground"), 
		    "Menu.disabledForeground", new ASColorUIResource(0x888888), 
		    "Menu.acceleratorFont", table.getFont("menuFont"), 
		    "Menu.acceleratorForeground", table.get("menuText"), 
		    "Menu.acceleratorSelectionForeground", table.get("menu"), 
	    	"Menu.border", null, 
	    	"Menu.arrowIcon", org.aswing.plaf.basic.icon.MenuArrowIcon, 
	    	"Menu.checkIcon", org.aswing.plaf.basic.icon.MenuCheckIcon, 
			"Menu.margin", new InsetsUIResource(0, 0, 0, 0), 
			"Menu.useMenuBarBackgroundForTopLevel", true, 
			"Menu.menuPopupOffsetX", 0, 
			"Menu.menuPopupOffsetY", 0, 
			"Menu.submenuPopupOffsetX", -4, 
			"Menu.submenuPopupOffsetY", 0
	    ];
	    table.putDefaults(comDefaults);
	    
	     // *** PopupMenu
	    comDefaults = [
		    "PopupMenu.background", new ASColorUIResource(0xf0f0f0, 0.95),
		    "PopupMenu.foreground", table.get("menuText"), 
			"PopupMenu.mideground", table.get("controlMide"), 
			"PopupMenu.colorAdjust", new UIStyleTune(0.14, -0.14, 0.06, 0.20, 0), 
	    	"PopupMenu.opaque", true, 
	    	"PopupMenu.focusable", false, 
	        "PopupMenu.font", table.getFont("menuFont"),
	        "PopupMenu.borderColor", table.get("controlDkShadow"),
	    	"PopupMenu.border", org.aswing.plaf.basic.border.PopupMenuBorder
	    ];
	    table.putDefaults(comDefaults);
	    
	    // *** MenuBar
	    comDefaults = [
		    "MenuBar.background", table.get("menu"), 
		    "MenuBar.foreground", table.get("menuText"), 
			"MenuBar.mideground", table.get("controlMide"), 
			"MenuBar.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20), 
	    	"MenuBar.opaque", false, 
	    	"MenuBar.focusable", true, 
	        "MenuBar.font", table.getFont("menuFont"), 
	    	"MenuBar.border", null];
	    table.putDefaults(comDefaults);
	}
	
}