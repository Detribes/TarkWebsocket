import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/models/ticker.dart';
import 'package:test_app/repositories/repository.dart';

part 'live_price_state.dart';
part 'live_price_event.dart';

class LivePricesBloc extends Bloc<LivePriceEvent, LivePricesState> {
  final IRepository _repository;
  StreamSubscription? _tickerSubscription;

  LivePricesBloc(this._repository) : super(LivePricesInitial()){
    on<FetchLivePrice>(_mapFetchLivePricesToState);
    on<LivePriceUpdated>(_onUpdateLivePrices);
    _tickerSubscription?.cancel();
  }

  _mapFetchLivePricesToState(FetchLivePrice event, Emitter<LivePricesState> emit) async {
    emit(LivePricesLoading());
    try {
      await _tickerSubscription?.cancel();
      _tickerSubscription = await _repository.connectToStream(
          event.searchQuery.isNotEmpty
              ? "${event.searchQuery}usdt"
              : ""
      )
          .listen((List<Ticker> tickers) {
        add(LivePriceUpdated(tickers));
      });
    } catch (e) {
      emit(LivePricesError(message: 'Failed to fetch tickers: $e'));
      log(e.toString());
    }
  }
  _onUpdateLivePrices(LivePriceUpdated event, Emitter<LivePricesState> emit){
    emit(LivePricesLoaded(event.tickers));
  }

  @override
  Future<void> close() async {
    await _repository.disconnectStream();
    _tickerSubscription?.cancel();
    return super.close();
  }
}