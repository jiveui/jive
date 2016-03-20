package discount.viewmodel;

import bindx.IBindable;

import openfl.Assets;

import org.aswing.ASColor;
import org.aswing.ASFont;
import org.aswing.Insets;
import org.aswing.AssetBackground;
import org.aswing.JSpacer;
import org.aswing.UIManager;
import org.aswing.geom.IntDimension;

import jive.plaf.flat.background.FlatFrameAroundBackground;

import flash.events.Event;
import flash.display.Loader;
import flash.net.URLRequest;
import flash.display.Bitmap;

import common.types.Partner;
import common.Client;

class SinglePartnerViewModel implements IBindable {
    @bindable public var partnerName: String;
    @bindable public var partnerAddress: String;
    public var partnerPhone: String;
    @bindable public var comments: String;

    @bindable public var commentsVisible: Bool = false;
    @bindable public var imageVisible: Bool = false;
    @bindable public var phoneVisible: Bool = false;

    @bindable public var partnerLogo: AssetBackground;
    @bindable public var partnerLogoFrame: FlatFrameAroundBackground;
    @bindable public var mediumFont: ASFont;

    public var partner: Partner;

    public function new(partner: Partner) {
        this.partner = partner;

        this.partnerName = partner.legalName;
        this.partnerAddress = if (partner.branches != null && partner.branches.length > 0) partner.branches[0].address else partner.legalAddress;
        this.partnerPhone = if (partner.branches != null && partner.branches.length > 0) partner.branches[0].phone else partner.phone;
        this.comments = partner.shortDescription;

        if (this.partnerPhone.length > 0)
            this.partnerAddress += ", тел.: " + this.partnerPhone;

        var logo: Dynamic = Controller.instance.getLogo(partner);
        var image: String = if (logo != null) Client.URL + "/" + logo.url else "";

        mediumFont = UIManager.get('mediumControlFont');

        if (partnerPhone.length > 0)
            phoneVisible = true;

        if (image.length > 0) {
            var logoLoader = new Loader();
            logoLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, logoListener);
            logoLoader.load(new URLRequest(image));

        }
    }

    private function logoListener(e: Event) {
        var bitmapLogo: Bitmap = e.target.loader.content;
        if (bitmapLogo != null) {
            imageVisible = true;
            bitmapLogo.width = Std.int(UIManager.get('fontSize') * 4.5 * 4.0);
            bitmapLogo.height = Std.int(UIManager.get('fontSize') * 4.5 * 4.0);

            partnerLogo = new AssetBackground(bitmapLogo, true);
            partnerLogoFrame = new FlatFrameAroundBackground();
        }
    }
}
