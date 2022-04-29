class AmiAmiItem {
  final String productUrl;
  final String imageUrl;
  final String productName;
  final String price;
  final String productCode;
  final String availability;
  final AmiAmiFlags flags;

  AmiAmiItem(
    this.productUrl,
    this.imageUrl,
    this.productName,
    this.price,
    this.productCode,
    this.availability,
    this.flags,
  );
}

class AmiAmiFlags {
  final bool inStock;
  final bool isClosed;
  final bool isPreorder;
  final bool isBackorder;
  final bool isPreowned;

  AmiAmiFlags(
    this.inStock,
    this.isClosed,
    this.isPreorder,
    this.isBackorder,
    this.isPreowned,
  );
}

class AmiAmiProductInfo {
  String? gcode;
  String? gname;
  String? thumbUrl;
  String? thumbAlt;
  String? thumbTitle;
  int? minPrice;
  int? maxPrice;
  int? cPriceTaxed;
  String? makerName;
  int? saleitem;
  int? conditionFlg;
  int? listPreorderAvailable;
  int? listBackorderAvailable;
  int? listStoreBonus;
  int? listAmiamiLimited;
  int? instockFlg;
  int? orderClosedFlg;
  dynamic elementId;
  String? salestatus;
  String? salestatusDetail;
  String? releasedate;
  String? jancode;
  int? preorderitem;
  int? saletopitem;
  int? resaleFlg;
  dynamic preownedSaleFlg;
  int? forWomenFlg;
  int? genreMoe;
  dynamic cate6;
  dynamic cate7;
  int? buyFlg;
  int? buyPrice;
  dynamic buyRemarks;
  int? stockFlg;
  int? imageOn;
  String? imageCategory;
  String? imageName;
  dynamic metaalt;

  AmiAmiProductInfo(
      {this.gcode,
      this.gname,
      this.thumbUrl,
      this.thumbAlt,
      this.thumbTitle,
      this.minPrice,
      this.maxPrice,
      this.cPriceTaxed,
      this.makerName,
      this.saleitem,
      this.conditionFlg,
      this.listPreorderAvailable,
      this.listBackorderAvailable,
      this.listStoreBonus,
      this.listAmiamiLimited,
      this.instockFlg,
      this.orderClosedFlg,
      this.elementId,
      this.salestatus,
      this.salestatusDetail,
      this.releasedate,
      this.jancode,
      this.preorderitem,
      this.saletopitem,
      this.resaleFlg,
      this.preownedSaleFlg,
      this.forWomenFlg,
      this.genreMoe,
      this.cate6,
      this.cate7,
      this.buyFlg,
      this.buyPrice,
      this.buyRemarks,
      this.stockFlg,
      this.imageOn,
      this.imageCategory,
      this.imageName,
      this.metaalt});

  AmiAmiProductInfo.fromJson(Map<String, dynamic> json) {
    gcode = json['gcode'];
    gname = json['gname'];
    thumbUrl = json['thumb_url'];
    thumbAlt = json['thumb_alt'];
    thumbTitle = json['thumb_title'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    cPriceTaxed = json['c_price_taxed'];
    makerName = json['maker_name'];
    saleitem = json['saleitem'];
    conditionFlg = json['condition_flg'];
    listPreorderAvailable = json['list_preorder_available'];
    listBackorderAvailable = json['list_backorder_available'];
    listStoreBonus = json['list_store_bonus'];
    listAmiamiLimited = json['list_amiami_limited'];
    instockFlg = json['instock_flg'];
    orderClosedFlg = json['order_closed_flg'];
    elementId = json['element_id'];
    salestatus = json['salestatus'];
    salestatusDetail = json['salestatus_detail'];
    releasedate = json['releasedate'];
    jancode = json['jancode'];
    preorderitem = json['preorderitem'];
    saletopitem = json['saletopitem'];
    resaleFlg = json['resale_flg'];
    preownedSaleFlg = json['preowned_sale_flg'];
    forWomenFlg = json['for_women_flg'];
    genreMoe = json['genre_moe'];
    cate6 = json['cate6'];
    cate7 = json['cate7'];
    buyFlg = json['buy_flg'];
    buyPrice = json['buy_price'];
    buyRemarks = json['buy_remarks'];
    stockFlg = json['stock_flg'];
    imageOn = json['image_on'];
    imageCategory = json['image_category'];
    imageName = json['image_name'];
    metaalt = json['metaalt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gcode'] = gcode;
    data['gname'] = gname;
    data['thumb_url'] = thumbUrl;
    data['thumb_alt'] = thumbAlt;
    data['thumb_title'] = thumbTitle;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['c_price_taxed'] = cPriceTaxed;
    data['maker_name'] = makerName;
    data['saleitem'] = saleitem;
    data['condition_flg'] = conditionFlg;
    data['list_preorder_available'] = listPreorderAvailable;
    data['list_backorder_available'] = listBackorderAvailable;
    data['list_store_bonus'] = listStoreBonus;
    data['list_amiami_limited'] = listAmiamiLimited;
    data['instock_flg'] = instockFlg;
    data['order_closed_flg'] = orderClosedFlg;
    data['element_id'] = elementId;
    data['salestatus'] = salestatus;
    data['salestatus_detail'] = salestatusDetail;
    data['releasedate'] = releasedate;
    data['jancode'] = jancode;
    data['preorderitem'] = preorderitem;
    data['saletopitem'] = saletopitem;
    data['resale_flg'] = resaleFlg;
    data['preowned_sale_flg'] = preownedSaleFlg;
    data['for_women_flg'] = forWomenFlg;
    data['genre_moe'] = genreMoe;
    data['cate6'] = cate6;
    data['cate7'] = cate7;
    data['buy_flg'] = buyFlg;
    data['buy_price'] = buyPrice;
    data['buy_remarks'] = buyRemarks;
    data['stock_flg'] = stockFlg;
    data['image_on'] = imageOn;
    data['image_category'] = imageCategory;
    data['image_name'] = imageName;
    data['metaalt'] = metaalt;
    return data;
  }
}

class AmiAmiResultSet {
  List<AmiAmiItem> items = [];
  int maxItems = -1;
  bool init = false;
  int pages = -1;
  int _itemCount = 0;

  void add(AmiAmiProductInfo productInfo) {
    /// True if item is in stock
    ///
    /// for future reference
    /// there seems to be 3 different stock flags
    /// stock, stock_flg and instock_flg
    /// stock seems to be only for the item page itself, not the results page
    /// stock_flg seems to be 1 everywhere no matter what
    /// instock_flg seems to be 1 when you can click to order the item HOWEVER
    /// instock_flg will be 0 on the item page itself, but not on the results
    /// therefore, we use instock since we're using results page
    bool inStock = productInfo.instockFlg == 1;

    /// Reflects wether or not the item is closed
    bool isClosed = productInfo.orderClosedFlg == 1;

    bool isPreorder = productInfo.preorderitem == 1;
    bool isBackorder = productInfo.listBackorderAvailable == 1;

    // this was found by looking at the filter they provide and seeing the
    // s_st_condition_flag query they pass. Not sure entirely yet, but seems
    // to be ok so far?
    bool isPreowned = productInfo.conditionFlg == 1;

    AmiAmiFlags flags = AmiAmiFlags(
      inStock,
      isClosed,
      isPreorder,
      isBackorder,
      isPreowned,
    );

    String availibility = "Unknown status?";
  }
}
