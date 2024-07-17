import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/live_price_bloc.dart';
import 'package:test_app/models/ticker.dart';
import 'package:test_app/screens/mainscreen_widgets/ticker_list_item.dart';

class TickerList extends StatelessWidget{
  const TickerList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LivePricesBloc, LivePricesState>(
      builder: (context, state) {
        if (state is LivePricesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LivePricesLoaded) {
          return ListView.builder(
            itemCount: state.tickers.length,
            itemBuilder: (context, index) {
              Ticker ticker = state.tickers[index];
              return TickerListItem(ticker: ticker);
            },
          );
        } else if (state is LivePricesError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }

}