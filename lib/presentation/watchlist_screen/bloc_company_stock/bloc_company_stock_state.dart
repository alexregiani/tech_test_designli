part of 'bloc_company_stock_bloc.dart';

enum CompanyStockStatus { initial, loading, success, failure }

class CompanyStockState extends Equatable {
  const CompanyStockState({
    this.appleStatus = CompanyStockStatus.initial,
    this.binanceStatus = CompanyStockStatus.initial,
    this.appleStock,
    this.binanceStock,
    this.appleError,
    this.binanceError,
  });

  final CompanyStockStatus appleStatus;
  final CompanyStockStatus binanceStatus;
  final CompanyStockEntity? appleStock;
  final CompanyStockEntity? binanceStock;
  final String? appleError;
  final String? binanceError;

  CompanyStockState copyWith({
    CompanyStockStatus? appleStatus,
    CompanyStockStatus? binanceStatus,
    CompanyStockEntity? appleStock,
    CompanyStockEntity? binanceStock,
    String? appleError,
    String? binanceError,
  }) {
    return CompanyStockState(
      appleStatus: appleStatus ?? this.appleStatus,
      binanceStatus: binanceStatus ?? this.binanceStatus,
      appleStock: appleStock ?? this.appleStock,
      binanceStock: binanceStock ?? this.binanceStock,
      appleError: appleError ?? this.appleError,
      binanceError: binanceError ?? this.binanceError,
    );
  }

  @override
  List<Object?> get props => [
        appleStatus,
        binanceStatus,
        appleStock,
        binanceStock,
        appleError,
        binanceError,
      ];
}
