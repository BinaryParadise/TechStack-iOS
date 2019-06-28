function NSObject() {
    this.name = "Polygon";
}
function demo() {
    hellooc();
    console.warn(SNBridge.controller);
    var obj = SNBridge.controller().new({background:0xF6F6F6});
    console.warn(obj.view);
    return obj;
}
