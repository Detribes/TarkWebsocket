import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/live_price_bloc.dart';
import 'package:test_app/screens/mainscreen_widgets/search_bar.dart';
import 'package:test_app/screens/mainscreen_widgets/ticker_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LivePricesBloc>(context).add(const FetchLivePrice(searchQuery: ""));
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF212630),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: SearchWidget()
            ),
            SizedBox(height: 40.0,),
            Expanded(
              child: TickerList(),
            ),
          ],
        ),
      ),
    );
  }
}