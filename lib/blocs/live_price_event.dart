part of 'live_price_bloc.dart';

@immutable
abstract class LivePriceEvent extends Equatable {
  const LivePriceEvent();

  @override
  List<Object> get props => [];
}

class FetchLivePrice extends LivePriceEvent {
  final String searchQuery;

  const FetchLivePrice({required this.searchQuery});

  @override
  List<Object> get props => [LivePriceEvent];

}

class LivePriceUpdated extends LivePriceEvent {
  final List<Ticker> tickers;

  const LivePriceUpdated(this.tickers);

  @override
  List<Object> get props => [tickers];
}