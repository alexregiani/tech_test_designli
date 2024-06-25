// part of 'bloc_company_stock_bloc.dart';
//
// sealed class CompanyStockState extends Equatable {
//   const CompanyStockState();
// }
//
// final class CompanyStockInitialState extends CompanyStockState {
//   @override
//   List<Object> get props => [];
// }
//
// //apple states
// final class AppleStockLoadingState extends CompanyStockState {
//   @override
//   List<Object> get props => [];
// }
//
// final class AppleStockSuccessState extends CompanyStockState {
//   const AppleStockSuccessState({required this.companyStock});
//
//   final CompanyStockEntity companyStock;
//   @override
//   List<Object> get props => [companyStock];
// }
//
// final class AppleStockFailureState extends CompanyStockState {
//   const AppleStockFailureState({required this.error});
//
//   final String error;
//   @override
//   List<Object> get props => [error];
// }
// // binance states
//
// final class BinanceStockLoadingState extends CompanyStockState {
//   @override
//   List<Object> get props => [];
// }
//
// final class BinanceStockSuccessState extends CompanyStockState {
//   const BinanceStockSuccessState({required this.companyStock});
//
//   final CompanyStockEntity companyStock;
//   @override
//   List<Object> get props => [companyStock];
// }
//
// final class BinanceStockFailureState extends CompanyStockState {
//   const BinanceStockFailureState({required this.error});
//
//   final String error;
//   @override
//   List<Object> get props => [error];
// }
part of 'bloc_company_stock_bloc.dart';

enum CompanyStockStatus { initial, loading, success, failure }

// enum CompanyType { apple, binance }

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
