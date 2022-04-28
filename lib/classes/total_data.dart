class TotalData {
  final double totalSpend;
  final double totalPrice;
  final double totalShipping;
  final double totalVat;
  final double totalDebt;
  final int importAmount;
  final double totalCollection;
  final int totalOrders;
  final int mangaAmount;
  final int figureAmount;
  final int gameAmount;
  final int otherAmount;
  final int canceledAmount;

  TotalData({
    required this.totalSpend,
    required this.totalPrice,
    required this.totalVat,
    required this.totalShipping,
    required this.totalCollection,
    required this.totalDebt,
    required this.totalOrders,
    required this.mangaAmount,
    required this.figureAmount,
    required this.gameAmount,
    required this.otherAmount,
    required this.canceledAmount,
    required this.importAmount,
  });
}
