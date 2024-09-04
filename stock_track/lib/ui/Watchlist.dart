import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:stock_track/core/provider/StockProvider.dart';
import 'package:stock_track/ui/chart.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  _WatchlistState createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  Box? watchlistBox;

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
  }

  _loadWatchlist() async {
    watchlistBox = await Hive.openBox('watchlistBox');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
  final stock =    Provider.of<Stockprovider>(context);
    List<String> watchlistItems = watchlistBox?.keys.toList().cast<String>() ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("WATCH LIST"),
      ),
      body: watchlistItems.isEmpty
          ? const Center(child: Text("No items in watchlist"))
          : ListView.builder(
              itemCount: watchlistItems.length,
              itemBuilder: (context, index) {
                final symbol=watchlistItems[index];
                final Stock = stock.stockData[symbol];
                 if (Stock == null) {
                  return ListTile(
                    title: Text(symbol),
                    subtitle: const Text('No data available'),
                  );
                }
                return ListTile(
                  title: Text(Stock['symbol']),
                  subtitle: Text(
                      'Price: \$${Stock['currentPrice'].toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${Stock['percentageChange'].toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: Stock['percentageChange'] >= 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                       IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      watchlistBox!.delete(watchlistItems[index]);
                      setState(() {});
                    },
                  ),],
                  ),
                  onTap: () {
                    stock.SelectedSymbol = symbol;
                    stock.SelectWeek = Stock['weeklyData'];
                    stock.fetchTimeSeries();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockChartScreen(),
                      ),
                    );
                  }
                );
              },
            ),
    );
  }
}
