class Ticker {
  String symbol;
  double close;
  double open;
  double volume;

  Ticker({
    required this.symbol,
    required this.close,
    required this.open,
    required this.volume
  });

  factory Ticker.fromJson(Map<String, dynamic> json) {
    return Ticker(
      symbol: json['s'],
      close: double.parse(json['c']),
      open: double.parse(json['o']),
      volume: double.parse(json['v']),
    );
  }
}
