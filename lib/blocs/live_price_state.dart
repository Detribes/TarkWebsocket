part of 'live_price_bloc.dart';

@immutable
abstract class LivePricesState extends Equatable {
  const LivePricesState();

  @override
  List<Object> get props => [];
}

class LivePricesInitial extends LivePricesState {}

class LivePricesLoading extends LivePricesState {}

class LivePricesLoaded extends LivePricesState {
  final List<Ticker> tickers;

  const LivePricesLoaded(this.tickers);

  @override
  List<Object> get props => [tickers];
}

class LivePricesError extends LivePricesState {
  final String message;

  const LivePricesError({required this.message});

  @override
  List<Object> get props => [message];
}