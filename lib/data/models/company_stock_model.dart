import 'package:tech_test_designli/core/typedefs.dart';
import 'package:tech_test_designli/domain/entities/company_stock_entity.dart';

class CompanyStockModel extends CompanyStockEntity {
  CompanyStockModel({
    required super.currentPrice,
    required super.change,
    required super.percentChange,
    required super.highPriceDay,
    required super.openPriceDay,
    required super.lowPriceDay,
    required super.previousClosePrice,
    required super.timestamp,
  });

  factory CompanyStockModel.fromJson(JSON json) {
    return CompanyStockModel(
      currentPrice: (json['c'] as num).toDouble(),
      change: (json['d'] as num).toDouble(),
      percentChange: (json['dp'] as num).toDouble(),
      highPriceDay: (json['h'] as num).toDouble(),
      openPriceDay: (json['o'] as num).toDouble(),
      lowPriceDay: (json['l'] as num).toDouble(),
      previousClosePrice: (json['pc'] as num).toDouble(),
      timestamp: (json['t'] as num).toInt(),
    );
  }
}
