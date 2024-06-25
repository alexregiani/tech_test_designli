import 'package:tech_test_designli/core/typedefs.dart';
import 'package:tech_test_designli/domain/entities/single_company_stock_entity.dart';

class SingleCompanyStockModel extends SingleCompanyStockEntity {
  SingleCompanyStockModel({
    required super.currentPrice,
    required super.change,
    required super.percentChange,
    required super.highPriceDay,
    required super.openPriceDay,
    required super.lowPriceDay,
    required super.previousClosePrice,
    required super.timestamp,
  });

  factory SingleCompanyStockModel.fromJson(JSON json) {
    return SingleCompanyStockModel(
      currentPrice: json['c'] as double,
      change: json['d'] as double,
      percentChange: json['dp'] as double,
      highPriceDay: json['h'] as double,
      openPriceDay: json['o'] as double,
      lowPriceDay: json['l'] as double,
      previousClosePrice: json['pc'] as double,
      timestamp: json['t'] as int,
    );
  }
}
