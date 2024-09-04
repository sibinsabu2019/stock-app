import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:stock_track/core/provider/StockProvider.dart';
import 'package:stock_track/ui/chart.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
    Box? watchlistBox;
    List<String> filteredItems = [];
  String query = '';
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadWatchlist();
  }
  void searchItem(String query) {
    final stock = Provider.of<Stockprovider>(context, listen: false);

    final suggestions = stock.stockSymbols.where((item) {
      final itemLower = item.toLowerCase();
      final queryLower = query.toLowerCase();
      return itemLower.contains(queryLower);
    }).toList();

    setState(() {
      this.query = query;
      filteredItems = suggestions;
    });
  }

  void selectItem(String selectedItem) {
    final stock = Provider.of<Stockprovider>(context, listen: false);

    if (stock.stockData[selectedItem] != null) {
      stock.SelectWeek = stock.stockData[selectedItem]["weeklyData"];
      stock.SelectedSymbol=selectedItem;
      stock.fetchTimeSeries();
      print("Selected Stock Data: ${stock.stockData[selectedItem]}");

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => StockChartScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No data available for $selectedItem')),
      );
    }
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

    print("Added to watchlist: $symbol");
    print("Current watchlist: ${watchlistBox!.keys.toList()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Stocks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: searchItem,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredItems.isEmpty && query.isEmpty
                ? const Center(child: Text('Start typing to search...'))
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final symbol=filteredItems[index];
                      return ListTile(
                        title: Text(symbol),
                        trailing: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _addToWatchlist(symbol),
                      ),
                        onTap: () => selectItem(filteredItems[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
