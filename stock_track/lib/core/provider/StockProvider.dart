import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Stockprovider  extends ChangeNotifier{
  int PageIndex=0;
Map<String, dynamic> stockData = {};
Map<String,dynamic>SelectWeek={};
Map<String,dynamic>SelectTime={};

 final List<String> stockSymbols = ['AAPL', 'GOOGL', 'TSLA', 'AMZN', 'MSFT', 'NFLX', 'FB', 'TSCO.LON', 'IBM', 'JPM'];
 String SelectedSymbol="";
 Map<String,dynamic>TimeSeries={};
 void changePage()
 {
  PageIndex=1;
  notifyListeners();
 }
 void clear()
 {
  SelectTime.clear();

 }
Future<void> fetchTimeSeries() async {
  final response = await http.get(
    Uri.parse("https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$SelectedSymbol&interval=5min&apikey=H8U9IJ6VKZH4HBMZ"),
  );

  if (response.statusCode == 200) {
    print("Success");
    final jsonData = json.decode(response.body);
    final timeSeries = jsonData['Time Series (5min)'];
    if (timeSeries != null) {
     
      int count = 0;

      timeSeries.forEach((key, value) {
        if (count % 10 == 0) {  
          print('$key: $value');
          DateTime dateTime = DateTime.parse(key);
          String time = DateFormat('HH:mm:ss').format(dateTime);
          SelectTime [time] = value;
        }
        count++;
      });
     notifyListeners();
      log("....${SelectTime .toString()}....TIME}");
    } else {
      print('No time series data available');
    }
  } else {
    print('Failed to fetch data');
  }
}
  



Future<void> fetchStockData() async {
  
 
    for (String symbol in stockSymbols) {
      final response = await http.get(
        Uri.parse('https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=$symbol&apikey=H8U9IJ6VKZH4HBMZ'),
      );

      if (response.statusCode == 200) {
      log("sucess");
        final jsonData = json.decode(response.body);
        print("Response for $symbol: $jsonData"); // Log the API response for debugging

        final timeSeries = jsonData['Weekly Time Series'];
        if (timeSeries != null) {
          final latestWeek = timeSeries.keys.first;
          final previousWeek = timeSeries.keys.elementAt(1);

          final latestClose = double.parse(timeSeries[latestWeek]['4. close']);
          final previousClose = double.parse(timeSeries[previousWeek]['4. close']);

          final percentageChange = ((latestClose - previousClose) / previousClose) * 100;

          
      stockData[symbol] = {
              'symbol': symbol,
              'currentPrice': latestClose,
              'percentageChange': percentageChange,
              'weeklyData': timeSeries, 
            };
         notifyListeners();
        } else {
         
            stockData[symbol] = null; 
       
          print('No time series data for $symbol'); 
          notifyListeners();
        }
      } else {
        
          stockData[symbol] = null; 
   
        print('Failed to fetch data for $symbol'); // Log failed API calls
        notifyListeners();
      }
    }
  }
}


