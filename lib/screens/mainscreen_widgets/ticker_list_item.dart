import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/ticker.dart';

class TickerListItem extends StatelessWidget{
  final Ticker ticker;
  const TickerListItem({super.key, required this.ticker});

  @override
  Widget build(BuildContext context) {
    double priceChangePercent24h = ((ticker.close - ticker.open) / ticker.open) * 100;
    Color priceColor = priceChangePercent24h >= 0
        ? const Color(0xFF2DBD85)
        : const Color(0xFFE44358);
    return ListTile(
      title: Row(
        children: [
          Text(ticker.symbol.substring(0, ticker.symbol.length-4),
            style: GoogleFonts.titilliumWeb(
              textStyle: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )
            ),
          ),
          Text('/USDT',
          style: GoogleFonts.titilliumWeb(
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(255, 255, 255, 0.4),
            )
          ),
          ),
          const SizedBox(width: 33.0,),
          Text(ticker.close.toStringAsFixed(2).replaceFirst('.', ','),
            style: GoogleFonts.barlow(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: priceColor,
                )
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Text('Vol ${ticker.volume.toStringAsFixed(2).replaceFirst('.', ',')}',
            style: GoogleFonts.titilliumWeb(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(255, 255, 255, 0.4),
                )
            ),
          ),
          const SizedBox(width: 33.0,),
          Text("${ticker.close.toStringAsFixed(2).replaceFirst('.', ',')}\$",
            style: GoogleFonts.barlow(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(255, 255, 255, 0.4),
                )
            ),
          ),
        ],
      ),
      // Avoid using Container 'cause it implements any Boxes without using Const on constructor under the hood
      trailing: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: priceColor,
        ),
        child: SizedBox(
          width: 103.0,
          height: 45.0,
          child: Center(
            child: Text(
              '${priceChangePercent24h >= 0 ? "+" : ""}${priceChangePercent24h.toStringAsFixed(2).replaceFirst('.', ',')}%',
              style: GoogleFonts.barlow(
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}