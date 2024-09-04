


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'package:stock_track/core/provider/StockProvider.dart';
import 'package:stock_track/ui/splash.dart';

void main()async {
  


  WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
  await Hive.openBox('watchlistBox');
  runApp(
    MultiProvider(providers: [ChangeNotifierProvider(create: (context) => Stockprovider(),),],child: StockApp(),)
  );
}

class StockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

