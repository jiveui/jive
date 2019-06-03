package demo.viewmodel;

import org.aswing.VectorListModel;
import openfl.Assets;
import jive.BaseCommand;
import jive.Command;
class TableViewModel extends ComboBoxViewModel {

    @:bindable public var isLoginDialogShowed: Bool;
    @:bindable public var openLoginDialogCommand: Command;
    @:bindable public var languages: VectorListModel;

    @:bindable public var selectedItem(default, set): Dynamic;
    private function set_selectedItem(v: Dynamic): Dynamic {
        selectedItem = v;
        informationPanelVisibility = null != selectedItem;
        if (informationPanelVisibility) {
            highest = selectedItem.highest;
            lowest = selectedItem.lowest;
            languageOfYear = selectedItem.languageOfYear;
        }
        return v;
    }

    @:bindable public var highest: String;
    @:bindable public var lowest: String;
    @:bindable public var languageOfYear: String;
    @:bindable public var informationPanelVisibility: Bool;

    public function new() {
        super();
        xmlSource = Assets.getText("assets/source/TableView.hml");
        haxeSource = Assets.getText("assets/source/TableViewModel.hx");
        isLoginDialogShowed = false;
        openLoginDialogCommand = new BaseCommand(function() { isLoginDialogShowed = true; });

        languages = new VectorListModel([
            { position: 1, prevPosition: 2, name: "Java", rating: 16.869, change: -0.04, highest: "#1 in May 2015", lowest: "#2 in Mar 2015", languageOfYear: "2005" },
            { position: 2, prevPosition: 1, name: "C", rating: 16.847, change: -0.08, highest: "#1 in Mar 2015", lowest: "#2 in May 2015", languageOfYear: "2008" },
            { position: 3, prevPosition: 4, name: "C++", rating: 7.875, change: 1.89, highest: "#3 in May 2015", lowest: "#5 in Feb 2008", languageOfYear: "2003" },
            { position: 4, prevPosition: 3, name: "Objective-C", rating: 5.393, change: -6.40, highest: "#3 in Mar 2015", lowest: "#59 in Dec 2007", languageOfYear: "2011, 2012" },
            { position: 5, prevPosition: 6, name: "C#", rating: 5.264, change: 1.52, highest: "#3 in Mar 2012", lowest: "#22 in Sep 2001", languageOfYear: "-" },
            { position: 6, prevPosition: 8, name: "Python", rating: 3.725, change: 0.67, highest: "#4 in Feb 2011", lowest: "#13 in Feb 2003", languageOfYear: "2007, 2010" },
            { position: 7, prevPosition: 9, name: "JavaScript", rating: 3.127, change: 1.34, highest: "#6 in Apr 2015", lowest: "#12 in Oct 2014", languageOfYear: "2014" },
            { position: 8, prevPosition: 11, name: "Visual Basic .NET", rating: 2.968, change: 1.7, highest: "#8 in May 2015", lowest: "#49 in Jan 2011", languageOfYear: "-" },
            { position: 9, prevPosition: 7, name: "PHP", rating: 2.72, change: -0.67, highest: "#3 in Mar 2010", lowest: "#10 in Sep 2001", languageOfYear: "2004" },
            { position: 10, prevPosition: 99 , name: "Visual Basic", rating: 1.893, change: 1.893, highest: "#9 in Apr 2015", lowest: "#17 in Jan 2015", languageOfYear: "-" },
            { position: 11, prevPosition: 10, name: "Perl", rating: 1.82, change: 0.35, highest: "#3 in May 2005", lowest: "#13 in Apr 2014", languageOfYear: "-" },
            { position: 12, prevPosition: 33, name: "R", rating: 1.444, change: 1.06, highest: "#12 in May 2015", lowest: "#73 in Dec 2008", languageOfYear: "-" },
            { position: 13, prevPosition: 15, name: "Delphi/Object Pascal", rating: 1.302, change: 0.33, highest: "#6 in Oct 2001", lowest: "#20 in Jan 2015", languageOfYear: "-" },
            { position: 14, prevPosition: 19, name: "MATLAB", rating: 1.283, change: 0.57, highest: "#11 in Jan 2015", lowest: "#29 in Aug 2011", languageOfYear: "-" },
            { position: 15, prevPosition: 12, name: "Ruby", rating: 1.273, change: 0.03, highest: "#8 in Dec 2008", lowest: "#39 in Jan 2002", languageOfYear: "2006" },
            { position: 16, prevPosition: 27, name: "COBOL", rating: 1.169, change: 0.58, highest: "#8 in Aug 2001", lowest: "#47 in Aug 2011", languageOfYear: "-" },
            { position: 17, prevPosition: 22, name: "PL/SQL", rating: 1.127 , change: 0.49, highest: "#7 in Apr 2005", lowest: "#67 in Apr 2004", languageOfYear: "-" },
            { position: 18, prevPosition: 99, name: "Swift", rating: 1.115, change: 1.115, highest: "#16 in Jul 2014", lowest: "#27 in Feb 2015", languageOfYear: "-" },
            { position: 19, prevPosition: 18, name: "Pascal", rating: 0.960, change: 0.21, highest: "#12 in Sep 2009", lowest: "#71 in Sep 2004", languageOfYear: "-" },
            { position: 20, prevPosition: 37, name: "ABAP", rating: 0.887, change: 0.57, highest: "#12 in Jan 2015", lowest: "#59 in Apr 2003", languageOfYear: "-" }
        ]);
    }
}
