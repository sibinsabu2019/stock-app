// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StockHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockAdapter extends TypeAdapter<StockHive> {
  @override
  final int typeId = 0;

  @override
  StockHive read(BinaryReader reader) {
    final symbol = reader.readString();
    final currentPrice = reader.readDouble();
    final percentageChange = reader.readDouble();
    return StockHive(
      symbol: symbol,
      currentPrice: currentPrice,
      percentageChange: percentageChange,
    );
  }

  @override
  void write(BinaryWriter writer, StockHive obj) {
    writer.writeString(obj.symbol);
    writer.writeDouble(obj.currentPrice);
    writer.writeDouble(obj.percentageChange);
  }
}
