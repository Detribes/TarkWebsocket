import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/blocs/live_price_bloc.dart';

class SearchWidget extends StatelessWidget{
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: TextField(
        style: GoogleFonts.barlow(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                color: Color.fromRGBO(255, 255, 255, 0.3)
            )
        ),
        decoration: InputDecoration(
          hintText: 'Search coin pairs',
          hintStyle: GoogleFonts.barlow(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              color: Color.fromRGBO(255, 255, 255, 0.3)
            )
          ),
          prefixIcon: const Icon(Icons.search,
              weight: 400.0,
              color: Color.fromRGBO(255, 255, 255, 0.3),
              size: 24.0,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.0),
          ),
          filled: true,
          fillColor: const Color(0xFF29303D)
        ),
        onChanged: (query) {
          BlocProvider.of<LivePricesBloc>(context).add(FetchLivePrice(searchQuery: query));
        },
      ),
    );
  }

}