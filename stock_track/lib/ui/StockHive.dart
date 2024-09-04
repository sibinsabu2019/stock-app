import 'package:hive/hive.dart';

part 'StockHive.g.dart';  
@HiveType(typeId: 0)
class StockHive {
  @HiveField(0)
  final String symbol;

  @HiveField(1)
  final double currentPrice;

  @HiveField(2)
  final double percentageChange;

  StockHive({
    required this.symbol,
    required this.currentPrice,
    required this.percentageChange,
  });
}
