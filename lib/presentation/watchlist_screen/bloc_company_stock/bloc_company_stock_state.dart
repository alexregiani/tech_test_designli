part of 'bloc_company_stock_bloc.dart';

sealed class CompanyStockState extends Equatable {
  const CompanyStockState();
}

final class CompanyStockInitialState extends CompanyStockState {
  @override
  List<Object> get props => [];
}

final class CompanyStockLoadingState extends CompanyStockState {
  @override
  List<Object> get props => [];
}

final class CompanyStockSuccessState extends CompanyStockState {
  const CompanyStockSuccessState({required this.companyStock});

  final CompanyStockEntity companyStock;
  @override
  List<Object> get props => [companyStock];
}

final class CompanyStockFailureState extends CompanyStockState {
  const CompanyStockFailureState({required this.error});

  final String error;
  @override
  List<Object> get props => [error];
}
