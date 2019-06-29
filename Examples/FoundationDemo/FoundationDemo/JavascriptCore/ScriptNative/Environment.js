function demo() {
    hellooc();
    var vc = SNViewController.alloc().init();
    vc.view().setBackgroundColor(UIColor.sn_colorWithHex(0xF6F6F6));
    var contentView = UIView.alloc().initWithFrame({x:16,y:108, width: 200, height: 300});
    contentView.setBackgroundColor(UIColor.sn_colorWithHex(0xFE5B60));
    vc.view().addSubview(contentView);
    return toObjC(vc);
}
