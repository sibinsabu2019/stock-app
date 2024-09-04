import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_track/core/provider/StockProvider.dart';
import 'package:stock_track/ui/Stocks.dart';
import 'package:stock_track/widget/button.dart';
import 'package:stock_track/widget/items.dart';
import 'package:stock_track/widget/scroll.dart';
import 'package:stock_track/widget/squareButton.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final List<Item> items = [
  Item(name: 'Life Insurance', color: Colors.blue, icon: Icons.safety_check),
  Item(name: 'Import Stocks', color: Colors.green, icon: Icons.stacked_bar_chart),
  Item(name: 'Import MF', color: Colors.red, icon: Icons.money),
  Item(name: 'Import Banks', color: Colors.orange, icon: Icons.account_balance),
  Item(name: 'Invest in Gold', color: Colors.yellow, icon: Icons.star),
  Item(name: 'Invest in Bonds', color: Colors.purple, icon: Icons.attach_money),
];

   final List<String> stocks = [
    "NIFTY BANK ↓ 23,9898 (-10%)",
    "GOLD 24K ↑ 50,234 (+5%)",
    "SENSEX ↓ 48,963 (-2%)",
    
  ];

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(appBar: AppBar(title: const Row(
      children: [
        Icon(Icons.person_4_outlined),
        Text("     Home"),
      ],
    ),),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
           const ScrollingTicker(
            items: [
              {'text': 'NIFTY BANK', 'value': '\u2193 23,9898', 'percentage': '(-10%)'},
              {'text': 'GOLD 24K', 'value': '\u2193 48,000', 'percentage': '(-1.5%)'},
              {'text': 'SENSEX', 'value': '\u2191 51,000', 'percentage': '(+2%)'},
              {'text': 'SILVER', 'value': '\u2191 65,000', 'percentage': '(+0.5%)'},
              
            ],
            scrollSpeed: 10.0, 
          ),
          SizedBox(height: 20,),
          Container(height: height*0.4,
          width: width,
          color: Colors.deepPurple[200],
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text("  Welcome! ",style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold),)
                 ,     const Text("  Ready to start your investment journey? ",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                  ,const SizedBox(height: 18,)
                 ,Row(
                   children: [
                    
                     Padding(
                       padding: const EdgeInsets.only(top:5,left: 12,right: 5,bottom: 10 ),
                       child: Button(height: height*0.04, width: width*0.15,
                       color: Colors.deepPurple,
                       borderColor: Colors.deepPurple[200],
                       value:"All",),
                     ),
                     
                     Padding(
                       padding: const EdgeInsets.only(top: 5,left: 5,bottom: 10),
                       child: Button(height: height*0.04, width: width*0.2, color: Colors.deepPurple[200],
                       value: "Goals",
                       borderColor: Colors.white,
                       ),
                     ),
                    
                   ],
                  
                 ),
                 const SizedBox(height: 16,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: ()
                        {
                            Provider.of<Stockprovider>(context,listen: false).changePage();

                        },
                        child: squareButton(height: height, width: width
                        ,color: Colors.deepPurple[100],
                        icon: Icons.bar_chart,
                        title: "Invest in stocks",
                        subtitle: "Checkout actively traded stocks",
                                
                        ),
                      ),
                     
        
                    ],
                  ),
                  const SizedBox(height: 10,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       squareButton(height: height, width: width
                          ,color: Colors.teal[600],
                          icon: Icons.eco,
                          title: "Invest in Mutual Funds",
                          subtitle: "Checkout top rated funds",
                       
                          ),
                     ],
                   ),
        
          ],),
          ),
          const Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text("Discover more",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
              ),
            ],
          ),
          SizedBox(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: Column(
                    children: [
                    
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Container(
                              width: 100,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                 
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: item.color,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        item.icon,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  
                                  Text(
                                    item.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(height: height*0.24,
                width:width* 0.9,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)
                  ,
                  color: Colors.teal[600]
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Column(mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                    const Text(
                  '    Start investing instantly\n    with curated MF baskets',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                   
                  },
                  style: ElevatedButton.styleFrom(
                     
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('Get started',style: TextStyle(color: Colors.deepPurple),),
                ),
                  ],),

                  Image.asset("assets/investment.png",height: height*0.2,width: width*0.4,)
                ],),
                ),
                const SizedBox(height: 60,)
          ],
          
        ),
      ));
  }
}

