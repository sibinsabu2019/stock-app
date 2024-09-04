import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_track/core/provider/StockProvider.dart';
import 'package:stock_track/ui/Stocks.dart';
import 'package:stock_track/ui/Watchlist.dart';
import 'package:stock_track/ui/chart.dart';
import 'package:stock_track/ui/home.dart';
import 'package:stock_track/ui/more.dart';
import 'package:stock_track/ui/serchscreen.dart';

class StockListScreen extends StatefulWidget {
  @override
  _StockListScreenState createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
   // Replace with your actual API key
  

  @override
  void initState() {
    super.initState();
    Provider.of<Stockprovider>(context,listen: false) .fetchStockData();

  }

  
List<Widget>pages=[Home(),STocks(),Watchlist(),MorePage()];
  @override
  Widget build(BuildContext context) {
    final stock=Provider.of<Stockprovider>(context);
   

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index)
        {
           setState(() {
         stock.PageIndex=index;
          });
        },
        currentIndex:stock. PageIndex,
        items:const [
        BottomNavigationBarItem(icon: Icon(Icons.home),
        label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.stacked_line_chart)
        ,label: "Stocks"),
        BottomNavigationBarItem(icon: Icon(Icons.watch_later)
        ,label: "WatchList"),
        BottomNavigationBarItem(icon: Icon(Icons.more)
        ,label: "More")
      ]),
      
      body:pages[stock.PageIndex]
    );
  }
}