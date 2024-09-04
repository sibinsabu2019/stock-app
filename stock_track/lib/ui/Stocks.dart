import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:stock_track/core/provider/StockProvider.dart';
import 'package:stock_track/ui/chart.dart';
import 'package:stock_track/ui/serchscreen.dart';

class STocks extends StatefulWidget {
  const STocks({super.key});

  @override
  State<STocks> createState() => _STocksState();
}

class _STocksState extends State<STocks> {
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

  _addToWatchlist(String symbol) async {
    if (watchlistBox!.length >= 2) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Watchlist can only contain 2 items.'),
      ));
      return;
    }

    if (watchlistBox!.containsKey(symbol)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Item already in watchlist.'),
      ));
      return;
    }

    await watchlistBox!.put(symbol, true);
    setState(() {});

    // Log for debugging
    print("Added to watchlist: $symbol");
    print("Current watchlist: ${watchlistBox!.keys.toList()}");
  }

  @override
  Widget build(BuildContext context) {
    final stock = Provider.of<Stockprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock List'),
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchPage(),
              ))
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: stock.stockData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: stock.stockSymbols.length,
              itemBuilder: (context, index) {
                var symbol = stock.stockSymbols[index];
                final Stock = stock.stockData[symbol];

                if (Stock == null) {
                  return ListTile(
                    title: Text(symbol),
                    subtitle: const Text('No data available'),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    tileColor: Colors.grey[200],
                  );
                }

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  title: Text(
                    Stock['symbol'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    'Price: \$${Stock['currentPrice'].toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${Stock['percentageChange'].toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 14,
                          color: Stock['percentageChange'] >= 0
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _addToWatchlist(symbol),
                      ),
                    ],
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
                  },
                );
              },
            ),
    );
  }
}
