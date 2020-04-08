/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.plaf.flat;

import flash.system.Capabilities;
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import jive.plaf.flat.adjuster.AdjusterBorder;
import jive.plaf.flat.background.FlatTableBackground;
import jive.plaf.flat.border.TableLineBorder;
import org.aswing.border.LineBorder;
import org.aswing.LookAndFeel;
import org.aswing.ASColor;
import org.aswing.ASFont;
import org.aswing.plaf.basic.border.LineBorderResource;
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
class FlatLookAndFeel extends LookAndFeel {
	
	private  var NULL_COLOR:ASColor;
	private  var NULL_FONT:ASFont;

	/**
	 * Need to extends it to make a completed LAF and implements features.
	 */
	public function new() {
	    NULL_COLOR=DefaultEmptyDecoraterResource.NULL_COLOR;
		NULL_FONT = DefaultEmptyDecoraterResource.NULL_FONT;
	}
	
	override public function getDefaults():UIDefaults{
		var table:UIDefaults  = new UIDefaults();

		initSizeDefaults(table);
        initClassDefaults(table);
		initSystemColorDefaults(table);
		initSystemFontDefaults(table);
		initCommonUtils(table);
		initComponentDefaults(table);
		
		return table;
	}

    private function initSizeDefaults(table:UIDefaults) {
        var size = 700;
        var fontSize: Float = 14;

        table.set("fontSize", Std.int(fontSize));
        table.set("textHorizontalMarginSize", Std.int(fontSize));
        table.set("textVerticalMarginSize", Std.int(fontSize/2));
        table.set("cornerSize", Std.int(fontSize/3));
        table.set("iconSize", Std.int(1.4 * fontSize));
        table.set("margin", Std.int(size/10));
        table.set("scrollBarWidth", Std.int(size/60));
        table.set("halfMargin", Std.int(size/20));
        table.set("iconGap", Std.int(0.5 * fontSize));
        table.set("dpiScale", Jive.scale);
    }

    private function initClassDefaults(table:UIDefaults):Void{
		var uiDefaults:Array<Dynamic>= [
               "ButtonUI", jive.plaf.flat.FlatButtonUI,
               "TextFieldUI",jive.plaf.flat.FlatTextFieldUI,
               "CheckBoxUI", jive.plaf.flat.FlatCheckBoxUI,
               "RadioButtonUI", jive.plaf.flat.FlatRadioButtonUI,
               "MenuUI", jive.plaf.flat.FlatMenuUI,
               "ComboBoxUI", jive.plaf.flat.FlatComboBoxUI,
               "ScrollBarUI", jive.plaf.flat.FlatScrollBarUI,
               "SliderUI",jive.plaf.flat.FlatSliderUI,
               "TabbedPaneUI", jive.plaf.flat.FlatTabbedPaneUI,
			   "AdjusterUI", jive.plaf.flat.FlatAdjusterUI,
			   "AccordionHeaderButtonUI", jive.plaf.flat.accordion.AccordionHeaderButtonUI,
			   "TableUI", jive.plaf.flat.FlatTableUI
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
            "white", 0xffffff,
            "turquoise", 0x1abc9c,
            "emerald", 0x2ecc71,
			"nephritis", 0x27ae60,
            "peter-river", 0x3498db,
            "amethyst", 0x9b59b6,
            "wet-asphalt", 0x34495e,
            "clouds", 0xecf0f1,
            "silver", 0xbdc3c7,
            "concrete", 0x95a5a6,
            "asbestos", 0x7f8c8d,
            "midnight-blue", 0x7f8c8d,
			"carrot", 0xe67e22,
			"pomegranate", 0xc0392b,
			"orange", 0xf39c12,
			"pumpkin",0xd35400
        ];

        for(i in 0...defaultSystemColors.length){
            table.set(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
        }

		defaultSystemColors = [
			"window", new ASColorUIResource(0xffffff),  //window panel background color
			"windowText", table.get("wet-asphalt"), /* ??? */
			"menu", table.get("wet-asphalt"), /* Background color for menus */
			"menuText", table.get("clouds"), /* Text color for menus  */
			"control", table.get("asbestos"), /* Default color for background in controls */
			"controlMide", table.get("silver"), /* Default color for thumb in controls */
			"controlText", new ASColorUIResource(0xffffff), /* Default color for text in controls */
			"selectionForeground", new ASColorUIResource(0xffffff),
            "focusForeground", table.get("turquoise"),
			"highlightControl", table.get("turquoise"),
			"darkControlBackground", table.get("wet-asphalt")
		];
		
		for(i in 0...defaultSystemColors.length){
			table.set(defaultSystemColors[i], defaultSystemColors[i+1]);
		}
		table.set("selectionBackground", table.get("highlightControl"));
		table.set("focusInner", new ASColorUIResource(0x40FF40, 0.3));
		table.set("focusOutter", new ASColorUIResource(0x40FF40, 0.4));
	}
	
	private function initSystemFontDefaults(table:UIDefaults):Void {
		#if cpp
		var defaultSystemFonts:Array<Dynamic>= [
			"systemFont", new ASFontUIResource("Lato Regular", 14 * Jive.scale),
			"menuFont", new ASFontUIResource("Lato Regular", 14 * Jive.scale),
            "topMenuFont", new ASFontUIResource("Lato Bold", 16 * Jive.scale),
			"controlFont", new ASFontUIResource("Lato Regular", 16 * Jive.scale),
			"windowFont", new ASFontUIResource("Lato Bold", 14 * Jive.scale),
            "controlHeaderFont", new ASFontUIResource("Lato Bold", 18 * Jive.scale)
		];
		#else
		var defaultSystemFonts:Array<Dynamic>= [
			"systemFont", new ASFontUIResource("Lato Regular", 14 * Jive.scale),
			"menuFont", new ASFontUIResource("Lato Regular", 14 * Jive.scale),
			"topMenuFont", new ASFontUIResource("Lato-Bold", 16 * Jive.scale),
			"controlFont", new ASFontUIResource("Lato Regular", 16 * Jive.scale),
			"windowFont", new ASFontUIResource("Lato Regular", 14 * Jive.scale, true),
			"controlHeaderFont", new ASFontUIResource("Lato Bold", 18 * Jive.scale)
		];
		#end
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
		var buttonBG:ASColorUIResource = table.get("silver");
		var textBG:ASColorUIResource = table.get("clouds");

		// *** Button
		var comDefaults:Array<Dynamic>= [
			"Button.background", buttonBG,
			"Button.foreground", table.get("white"),
            "Button.mideground", table.get("highlightControl"),
			"Button.opaque", true,
			"Button.focusable", true,  
			"Button.font", table.getFont("controlFont"),
			"Button.bg", jive.plaf.flat.background.FlatButtonBackground,
            "Button.colorAdjust", new UIStyleTune(0.18, -0.02, 0.34, 0.22, 5 * Jive.scale),
            "Button.margin", new InsetsUIResource(7, 15, 7, 15),
			"Button.textShiftOffset", 0,
            "Button.textFilters", null,
            "Button.textGap", 5
			 
		];
		table.putDefaults(comDefaults);
		var f = new Array<BitmapFilter>();
		f.push(new  DropShadowFilter(1, 45, 0, 0.0, 1, 1, 1, 1));
		// *** LabelButton
		comDefaults = [
			"LabelButton.background", buttonBG,
			"LabelButton.foreground", table.get("wet-asphalt"),
			"LabelButton.mideground", table.get("controlMide"), 
			"LabelButton.colorAdjust", new UIStyleTune(0.26, 0.05, 0.20, 0.20), 
			"LabelButton.opaque", false,  
			"LabelButton.focusable", true,  
			"LabelButton.font", new ASFontUIResource("Lato Regular", 16, false, false, true),
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

		// *** ToggleButton
		comDefaults = [
			"ToggleButton.background", buttonBG,
			"ToggleButton.foreground", table.get("clouds"),
			"ToggleButton.mideground", table.get("controlMide"), 
			"ToggleButton.colorAdjust", new UIStyleTune(0.18, -0.02, 0.34, 0.22, 5), 
			"ToggleButton.opaque", true, 
			"ToggleButton.focusable", true, 
			"ToggleButton.font", table.getFont("controlFont"),
			"ToggleButton.bg", jive.plaf.flat.background.FlatButtonBackground,
			"ToggleButton.margin", new InsetsUIResource(7, 15, 7, 15),
			"ToggleButton.textShiftOffset", 1,
            "ToggleButton.textFilters", null,
            "ToggleButton.textGap", 5
        ];
		table.putDefaults(comDefaults);
		
		// *** RadioButton
		comDefaults = [
			"RadioButton.background", table.get("silver"),
			"RadioButton.foreground", table.get("wet-asphalt"),
			"RadioButton.mideground", table.get("highlightControl"),
			"RadioButton.colorAdjust", new UIStyleTune(0.8, 0.01, 0.4, 0.30, 0, new UIStyleTune(0.4, 0.1, 0.1, 0.00)), 
			"RadioButton.opaque", false, 
			"RadioButton.focusable", true, 
			"RadioButton.font", table.getFont("systemFont"),
			"RadioButton.icon", jive.plaf.flat.icon.FlatRadioButtonIcon,
			"RadioButton.margin", new InsetsUIResource(0, 0, 0, 0),
			"RadioButton.textShiftOffset", 0,
            "RadioButton.textGap", 10,
			"RadioButton.textFilters", []
		];
		table.putDefaults(comDefaults);
		// *** TextField
		comDefaults = [
			"TextField.background", table.get("window"),
			"TextField.foreground", table.get("wet-asphalt"),
			"TextField.mideground", table.get("silver"),
			"TextField.colorAdjust", new UIStyleTune(0.0, -0.30, 0.0, 0.30, 3), 
			"TextField.opaque", true, 
			"TextField.focusable", true, 
			"TextField.font", table.getFont("systemFont"),
			"TextField.bg", jive.plaf.flat.background.FlatTextComponentBackground,
			"TextField.border", new EmptyBorderResource(null, new Insets(7, 15, 7, 15)) // empty space to make padding 8)
		];
		table.putDefaults(comDefaults);
		// *** CheckBox
		comDefaults = [
			"CheckBox.background", table.get("silver"),
			"CheckBox.foreground", table.get("windowText"),
			"CheckBox.mideground", table.get("highlightControl"),
            "CheckBox.tickColor", new ASColorUIResource(0xffffff),
			"CheckBox.colorAdjust", new UIStyleTune(0.8, 0.01, 0.4, 0.30, 5, new UIStyleTune(0.5, -0.2, 0.5, 0.70)),
			"CheckBox.opaque", false, 
			"CheckBox.focusable", true, 
			"CheckBox.font", table.getFont("systemFont"),
			"CheckBox.icon", jive.plaf.flat.icon.FlatCheckBoxIcon,
			"CheckBox.margin", new InsetsUIResource(0, 0, 0, 0), 
			"CheckBox.textShiftOffset", 0,
            "CheckBox.textGap", 10,
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
			"ScrollBar.background", new ASColorUIResource(0xe3e4e5),
			"ScrollBar.foreground", table.get("controlText"), 
			"ScrollBar.mideground", new ASColorUIResource(0xd1d1d1),
			"ScrollBar.colorAdjust", new UIStyleTune(0.18, 0.08, 0.20, 0.50, 5, new UIStyleTune(0.08, -0.3, 0.08, 0.20, 2)),
			"ScrollBar.opaque", true, 
			"ScrollBar.focusable", true, 
			"ScrollBar.barWidth", 12,
			"ScrollBar.minimumThumbLength", 24, 
			"ScrollBar.font", table.getFont("controlFont"),
			"ScrollBar.bg", jive.plaf.flat.background.FlatScrollBarBackground,
			"ScrollBar.thumbDecorator", jive.plaf.flat.background.FlatScrollBarThumb
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
			"ProgressBar.background", new ASColorUIResource(0xebedef),
			"ProgressBar.foreground", table.get("windowText"), 
			"ProgressBar.mideground", table.get("highlightControl"),
			"ProgressBar.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.50, 6, new UIStyleTune(0.34, -0.4, 0.01, 0.50, 6)),
			"ProgressBar.opaque", true, 
			"ProgressBar.focusable", false,	
			"ProgressBar.barWidth", 12, //means the size of bar
			"ProgressBar.font", new ASFontUIResource("Tahoma", 9), 
			"ProgressBar.bg", jive.plaf.flat.background.FlatProgressBarBackground,
			"ProgressBar.fg", jive.plaf.flat.background.FlatProgressBarIcon,
			"ProgressBar.indeterminateDelay", 100
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
			"Label.background", table.get("window"),
			"Label.foreground", table.get("windowText"),
			"Label.mideground", table.get("controlMide"), 
			"Label.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20),
			"Label.opaque", false, 
			"Label.focusable", false, 
			"Label.font", table.getFont("controlFont")
		];
		table.putDefaults(comDefaults);
		
	   
		
	   // *** TextArea
		comDefaults = [
            "TextArea.background", table.get("window"),
            "TextArea.foreground", table.get("wet-asphalt"),
            "TextArea.mideground", table.get("concrete"),
			"TextArea.colorAdjust", new UIStyleTune(0.0, -0.30, 0.0, 0.30, 5),
			"TextArea.opaque", true, 
			"TextArea.focusable", true, 
			"TextArea.font", table.getFont("controlFont"),
			"TextArea.bg", org.aswing.plaf.basic.background.TextComponentBackBround,
			"TextArea.border", new EmptyBorderResource(null, new Insets(7, 15, 7, 15))
		];
		table.putDefaults(comDefaults);
		
		// *** Frame
		comDefaults = [
			"Frame.background", new ASColorUIResource(0xfafafa),
			"Frame.foreground", new ASColorUIResource(0x666666), 
			"Frame.mideground", table.get("concrete"),
			"Frame.colorAdjust", new UIStyleTune(0.10, 0.0, 0.0, 0.30, 5, new UIStyleTune(0.10, 0.0, 0.0, 0.60, 5)),
			"Frame.opaque", true, 
			"Frame.focusable", true, 
			"Frame.dragDirectly", true, 
			"Frame.resizeArrow", new ASColorUIResource(0x2d6d89), 
			"Frame.resizeArrowLight", new ASColorUIResource(0xE2E2DE), 
			"Frame.resizeArrowDark",  new ASColorUIResource(0x2e6d8a), 		
			"Frame.resizer", org.aswing.resizer.DefaultResizer, 
			"Frame.font", table.get("controlFont"),
			"Frame.resizerMargin", new InsetsUIResource(2, 1, 6, 6), 
			"Frame.bg", jive.plaf.flat.background.FlatFrameBackground,
			"Frame.border", new EmptyBorderResource(null, new Insets(0, 40, 40, 40)),
			"Frame.icon", org.aswing.plaf.basic.icon.TitleIcon, 
			"Frame.iconifiedIcon", org.aswing.plaf.basic.icon.FrameIconifiedIcon, 
			"Frame.normalIcon", org.aswing.plaf.basic.icon.FrameNormalIcon, 
			"Frame.maximizeIcon", org.aswing.plaf.basic.icon.FrameMaximizeIcon, 
			"Frame.closeIcon", jive.plaf.flat.icon.FrameCloseIcon
		];
		table.putDefaults(comDefaults);		
		
		// *** FrameTitleBar
		comDefaults = [
			"FrameTitleBar.background", new ASColorUIResource(0xc4e066),
			"FrameTitleBar.foreground", table.get("wet-asphalt"),
			"FrameTitleBar.mideground", table.get("concrete"),
			"FrameTitleBar.colorAdjust", new UIStyleTune(0.24, 0.01, 0.18, 0.50, 0, new UIStyleTune(0.2, -0.28, 0.08, 0.10, 1)), 
			"FrameTitleBar.opaque", true, 
			"FrameTitleBar.focusable", false, 
			"FrameTitleBar.titleBarHeight", 50,
			"FrameTitleBar.buttonGap", 0,
			"FrameTitleBar.font", table.get("controlHeaderFont"),
			"FrameTitleBar.border", new EmptyBorderResource(null, new Insets(30, 0, 30, 0)),
			"FrameTitleBar.icon", org.aswing.plaf.basic.icon.TitleIcon,
			"FrameTitleBar.iconifiedIcon", org.aswing.plaf.basic.icon.FrameIconifiedIcon, 
			"FrameTitleBar.normalIcon", org.aswing.plaf.basic.icon.FrameNormalIcon, 
			"FrameTitleBar.maximizeIcon", org.aswing.plaf.basic.icon.FrameMaximizeIcon, 
			"FrameTitleBar.closeIcon", jive.plaf.flat.icon.FrameCloseIcon
		];
		table.putDefaults(comDefaults);
		f= new Array<BitmapFilter>();
		f.push(new  DropShadowFilter(4.0, 45, 0, 0.3, 2.0, 2.0, 0.5));
		// *** ToolTip
		comDefaults = [
			"ToolTip.background", table.get("silver"),
			"ToolTip.foreground", new ASColorUIResource(0xffffff),
			"ToolTip.mideground", table.get("silver"),
			"ToolTip.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20, 5),
			"ToolTip.opaque", true, 
			"ToolTip.focusable", false, 
			"ToolTip.font", table.getFont("controlFont"), 
			"ToolTip.filters", null,
			"ToolTip.bg", org.aswing.plaf.basic.background.ToolTipBackground, 
			"ToolTip.border", new EmptyBorderResource(null, new Insets(3, 7, 3, 3))
		];
		table.putDefaults(comDefaults);
		
		// *** List
		comDefaults = [
			"List.font", table.getFont("controlFont"),
			"List.background", new ASColorUIResource(0xffffff, 0),
			"List.foreground", table.get("windowText"),
			"List.mideground", table.get("silver"),
			"List.colorAdjust", new UIStyleTune(0.08, 0.05, 0.20, 0.20, 5),
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
            "ComboBox.font", table.getFont("systemFont"),
            "ComboBox.background", table.get("window"),
            "ComboBox.foreground", table.get("wet-asphalt"),
            "ComboBox.mideground", table.get("concrete"),
            "ComboBox.notEditableBackground", table.get("highlightControl"),
            "ComboBox.notEditableForeground", new ASColorUIResource(0xffffff),
			"ComboBox.colorAdjust", new UIStyleTune(0.0, -0.30, 0.0, 0.32, 5, new UIStyleTune(0.04, 0.05, 0.20, 0.1)),
			"ComboBox.opaque", true, 
			"ComboBox.focusable", true,
            "ComboBox.popupBackground", new ASColorUIResource(0xe3e4e5),
			"ComboBox.popupBorder", jive.plaf.flat.border.FlatComboBoxPopupBorder,
			"ComboBox.bg", jive.plaf.flat.background.FlatInputBackground,
			"ComboBox.border", new EmptyBorderResource(null, new Insets(7, 15, 7, 15))
		];
		table.putDefaults(comDefaults);
		
		// *** Slider
		comDefaults = [
			"Slider.font", table.getFont("controlFont"),
			"Slider.background", new ASColorUIResource(0xebedef),
			"Slider.foreground", table.get("windowText"),
			"Slider.mideground", table.get("highlightControl"),
            "Slider.progressColor", table.get("highlightControl"),
			"Slider.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.50, 6, new UIStyleTune(0.2, 0.00, 0.4, 0.00, 0)),
			"Slider.opaque", false,  
			"Slider.focusable", true, 
			"Slider.thumbIcon", jive.plaf.flat.icon.FlatSliderThumbIcon
		];
		table.putDefaults(comDefaults);
		
		// *** Adjuster
		comDefaults = [
			"Adjuster.background",  new ASColorUIResource(0xebedef),
			"Adjuster.foreground", table.get("windowText"),
			"Adjuster.mideground", table.get("windowText"),			
			"Adjuster.opaque", false,  
			"Adjuster.focusable", true,  
			"Adjuster.font", table.getFont("controlFont"), 
			"Adjuster.border", jive.plaf.flat.adjuster.AdjusterBorder,
			"Adjuster.bg", jive.plaf.flat.adjuster.AdjusterBackground,
			"Adjuster.cornerRadius", 5.0
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
			"Accordion.background", table.get("silver"),
			"Accordion.foreground", table.get("controlText"),
			"Accordion.mideground", table.get("controlMide"), 
			"Accordion.opaque", false,  
			"Accordion.focusable", true,
			"Accordion.motionSpeed", 1000, 
			"Accordion.tabMargin", new InsetsUIResource(5, 10, 7, 10),
			"Accordion.header", jive.plaf.flat.accordion.AccordionHeader,
			"Accordion.itemContainer", jive.plaf.flat.accordion.AccordionItemContainer,
		];
		table.putDefaults(comDefaults);
		
		// *** AccordionHeaderButton
		var comDefaults:Array<Dynamic> = [
			"AccordionHeaderButton.background", table.get("darkControlBackground"),
			"AccordionHeaderButton.foreground", table.get("controlText"),
			"AccordionHeaderButton.opaque", true,  
			"AccordionHeaderButton.focusable", true,  
			"AccordionHeaderButton.shadow", table.getColor("controlShadow"),		
			"AccordionHeaderButton.darkShadow", table.getColor("controlDkShadow"),		
			"AccordionHeaderButton.light", table.getColor("controlHighlight"),	   
	   		"AccordionHeaderButton.highlight", table.getColor("controlLtHighlight"),
			"AccordionHeaderButton.bg", jive.plaf.flat.accordion.AccordionHeaderButtonBackground,
			"AccordionHeaderButton.textShiftOffset", 1,
			"AccordionHeaderButton.cornerRadius", 5
		];
		table.putDefaults(comDefaults);
		
	   // *** JTabbedPane
		comDefaults = [
			"TabbedPane.background", table.get("window"),
			"TabbedPane.foreground", table.get("windowText"),
			"TabbedPane.mideground", new ASColorUIResource(0xcccccc),
			"TabbedPane.colorAdjust", new UIStyleTune(0.01, -0.14, 0.01, 0.50, 5, new UIStyleTune(0.05, -0.23, 0.01, 0.50, 4)),
			"TabbedPane.opaque", false,  
			"TabbedPane.focusable", true,  
			"TabbedPane.arrowShadowColor", new ASColorUIResource(0x000000),
			"TabbedPane.arrowLightColor", new ASColorUIResource(0x444444),
			"TabbedPane.font", table.getFont("controlFont"),
			"TabbedPane.tabMargin", new InsetsUIResource(7, 15, 7, 15),
			"TabbedPane.contentMargin", new InsetsUIResource(10, 2, 2, 2), 
			"TabbedPane.selectedTabExpandInsets", new InsetsUIResource(0, 0, 0, 0), 
			//indicate the insets of border bar
			"TabbedPane.tabBorderInsets", new InsetsUIResource(0, 0, 0, 0), //new InsetsUIResource(0, 18, 0, 18),
			"TabbedPane.contentRoundLineThickness", 1,
			"TabbedPane.tabGap", 3,
            "TabbedPane.tab", jive.plaf.flat.tabbedpane.FlatTabbedPaneTab,
			"TabbedPane.topBlankSpace", 0, 
			"TabbedPane.maxTabWidth", 1000];
		table.putDefaults(comDefaults);

        // *** TabButton
        comDefaults = [
            "TabButton.background", table.get("window"),
            "TabButton.foreground", table.get("windowText"),
            "TabButton.mideground", new ASColorUIResource(0xe1e1e1),
            "TabButton.colorAdjust", new UIStyleTune(0.01, -0.14, 0.01, 0.50, 5, new UIStyleTune(0.05, -0.23, 0.01, 0.50, 4)),
            "TabButton.focusable", true,
            "TabButton.font", table.getFont("controlFont"),
            "TabButton.colorAdjust", new UIStyleTune(0.18, -0.02, 0.34, 0.22, 5),
            "TabButton.margin", new InsetsUIResource(7, 15, 7, 15),
            "TabButton.textShiftOffset", 0,
            "TabButton.textFilters", null,
            "TabButton.textGap", 5,
            "TabButton.normalColor", new ASColorUIResource(0xffffff),
            "TabButton.rolloverColor", new ASColorUIResource(0xe1e1e1),
            "TabButton.selectedColor", new ASColorUIResource(0xffffff),
            "TabButton.borderColor", new ASColorUIResource(0xcccccc)
        ];
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
			"Table.background", new ASColorUIResource(0xffffff, 0.0),
			"Table.foreground", table.get("wet-asphalt"), 
			"Table.mideground", new ASColorUIResource(0xf1f1f1), 
			"Table.colorAdjust", new UIStyleTune(0.10, -0.2, 0.10, 0.20, 5), 
			"Table.opaque", true, 
			"Table.focusable", true, 
			"Table.font", table.getFont("controlFont"),
		    "Table.selectionBackground", table.get("selectionBackground"),
		    "Table.selectionForeground", table.get("selectionForeground"), 
			"Table.gridColor", new ASColorUIResource(0xd6d6d6), 
			"Table.bg", FlatTableBackground,
			"Table.border", new TableLineBorder(null, table.get("silver"), 1, 5)
		];
		table.putDefaults(comDefaults);
		
		 // *** TableHeader
		comDefaults = [
			"TableHeader.font", table.getFont("topMenuFont"), 
			"TableHeader.background", new ASColorUIResource(0xdbdbdb),
			"TableHeader.foreground", table.get("wet-asphalt"), 
			"TableHeader.mideground", table.get("silver"), 
			"TableHeader.colorAdjust", new UIStyleTune(0.06, 0.2, 0.10, 0.5, 0, new UIStyleTune(0.04, 0.05, 0.20, 0.1)), 
			"TableHeader.opaque", true, 
			"TableHeader.focusable", true, 
			"TableHeader.gridColor", new ASColorUIResource(0xd6d6d6),
			"TableHeader.bg", jive.plaf.flat.background.FlatTableHeaderBackground, 
			"TableHeader.border", null, 
			"TableHeader.cellBorder", jive.plaf.flat.border.TableHeaderCellBorder, 
			"TableHeader.sortableCellBorder", jive.plaf.flat.border.TableHeaderCellBorder
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
			"MenuItem.colorAdjust", new UIStyleTune(0.0, 0.0, 0.0, 0.0, 5),
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
			"MenuItem.margin", new InsetsUIResource(7, 15, 7, 15)
	    ];
	    table.putDefaults(comDefaults);
	    
	     // *** CheckBoxMenuItem
	    comDefaults = [
		    "CheckBoxMenuItem.background", table.get("menu"),
		    "CheckBoxMenuItem.foreground", table.get("menuText"), 
			"CheckBoxMenuItem.mideground", new ASColorUIResource(0x5d5d5d), 
			"CheckBoxMenuItem.colorAdjust", new UIStyleTune(0.0, 0.0, 0.0, 0.0, 5),
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
			"CheckBoxMenuItem.margin", new InsetsUIResource(7, 15, 7, 15)
	    ];
	    table.putDefaults(comDefaults);
	    
	     // *** RadioButtonMenuItem
	    comDefaults = [
		    "RadioButtonMenuItem.background", table.get("menu"),
		    "RadioButtonMenuItem.foreground", table.get("menuText"), 
			"RadioButtonMenuItem.mideground", new ASColorUIResource(0x5d5d5d), 
			"RadioButtonMenuItem.colorAdjust", new UIStyleTune(0.0, 0.0, 0.0, 0.0, 5),
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
			"RadioButtonMenuItem.margin", new InsetsUIResource(7, 15, 7, 15)
	    ];
	    table.putDefaults(comDefaults);
	    
	     // *** Menu
	    comDefaults = [
		    "Menu.background", table.get("menu"),
		    "Menu.foreground", table.get("menuText"), 
			"Menu.mideground", new ASColorUIResource(0x5d5d5d), 
			"Menu.colorAdjust", new UIStyleTune(0.0, 0.0, 0.0, 0.0, 5),
	    	"Menu.opaque", false, 
	    	"Menu.focusable", false, 
	        "Menu.font", table.getFont("menuFont"),
            "Menu.topMenuFont", table.getFont("topMenuFont"),
		    "Menu.selectionBackground", table.get("highlightControl"),
		    "Menu.selectionForeground", table.get("menuText"),
		    "Menu.disabledForeground", new ASColorUIResource(0x888888), 
		    "Menu.acceleratorFont", table.getFont("menuFont"), 
		    "Menu.acceleratorForeground", table.get("menuText"), 
		    "Menu.acceleratorSelectionForeground", table.get("menu"), 
	    	"Menu.border", null, 
	    	"Menu.arrowIcon", jive.plaf.flat.icon.FlatMenuArrowIcon,
	    	"Menu.checkIcon", org.aswing.plaf.basic.icon.MenuCheckIcon, 
			"Menu.margin", new InsetsUIResource(7, 15, 7, 15),
			"Menu.useMenuBarBackgroundForTopLevel", true, 
			"Menu.menuPopupOffsetX", 0, 
			"Menu.menuPopupOffsetY", 5,
			"Menu.submenuPopupOffsetX", 3,
			"Menu.submenuPopupOffsetY", 0,
            "Menu.textGap", 10
	    ];
	    table.putDefaults(comDefaults);
	    
	     // *** PopupMenu
	    comDefaults = [
		    "PopupMenu.background", table.get("menu"),
		    "PopupMenu.foreground", table.get("menuText"), 
			"PopupMenu.mideground", table.get("controlMide"), 
			"PopupMenu.colorAdjust", new UIStyleTune(0.14, -0.14, 0.06, 0.20, 5),
	    	"PopupMenu.opaque", true, 
	    	"PopupMenu.focusable", false, 
	        "PopupMenu.font", table.getFont("menuFont"),
	        "PopupMenu.borderColor", table.get("controlDkShadow"),
	    	"PopupMenu.border", jive.plaf.flat.border.FlatPopupMenuBorder
	    ];
	    table.putDefaults(comDefaults);
	    
	    // *** MenuBar
	    comDefaults = [
		    "MenuBar.background", table.get("menu"), 
		    "MenuBar.foreground", table.get("menuText"), 
			"MenuBar.mideground", table.get("highlightControl"),
			"MenuBar.colorAdjust", new UIStyleTune(0.18, 0.05, 0.20, 0.20, 5),
	    	"MenuBar.opaque", true,
	    	"MenuBar.focusable", true, 
	        "MenuBar.font", table.getFont("menuFont"),
	    	"MenuBar.border", null];
	    table.putDefaults(comDefaults);

		// *** Picker
		comDefaults = [
			"Picker.fg", jive.plaf.flat.background.FlatPickerForeground,
			"Picker.bg", jive.plaf.flat.background.FlatDatePickerBackground
		];
		table.putDefaults(comDefaults);
	}
	
}