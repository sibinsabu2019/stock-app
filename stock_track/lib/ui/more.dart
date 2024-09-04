import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('More Options'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.005), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(
                'Diversify Your Portfolio',
                style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.01),
              Text(
                'Investment beyond just stocks and mutual funds',
                style: TextStyle(fontSize: width * 0.04, color: Colors.grey[600]),
              ),
              SizedBox(height: height * 0.02),

              
              Container(
                height: height * 0.15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final items = [
                      {'name': 'Fixed Deposits', 'color': Colors.blue, 'icon': Icons.lock},
                      {'name': 'Gold', 'color': Colors.yellow, 'icon': Icons.star},
                      {'name': 'IPOs', 'color': Colors.green, 'icon': Icons.trending_up},
                      {'name': 'Peer-to-Peer Lending', 'color': Colors.orange, 'icon': Icons.people},
                    ];

                    final item = items[index];
                    return Container(
                      width: width * 0.22,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: width * 0.15 / 2, 
                            backgroundColor: item['color'] as Color,
                            child: Icon(item['icon'] as IconData, color: Colors.white, size: width * 0.15 / 2),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            item['name'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: width * 0.035),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              Divider(thickness: 1, color: Colors.grey[400]),

              
              SizedBox(height: height * 0.02),
              Text(
                'Investment Stable Returns',
                style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.01),
              Text(
                'Govt. backed fixed-income investments and more',
                style: TextStyle(fontSize: width * 0.04, color: Colors.grey[600]),
              ),
              SizedBox(height: height * 0.02),

              
              SizedBox(
                height: height * 0.15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final items = [
                      {'name': 'Govt Bonds', 'color': Colors.red, 'icon': Icons.attach_money},
                      {'name': 'T-Bills', 'color': Colors.blue, 'icon': Icons.money_off},
                      {'name': 'SDLs', 'color': Colors.green, 'icon': Icons.account_balance},
                      {'name': 'NCDs', 'color': Colors.purple, 'icon': Icons.paid},
                    ];

                    final item = items[index];
                    return Container(
                      width: width * 0.22,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: width * 0.15 / 2, 
                            backgroundColor: item['color'] as Color,
                            child: Icon(item['icon'] as IconData, color: Colors.white, size: width * 0.15 / 2),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            item['name'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: width * 0.035),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              Divider(thickness: 1, color: Colors.grey[400]),

              
              SizedBox(height: height * 0.02),
              Text(
                'Insurance',
                style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.01),
              Text(
                'Top plans at affordable prices for you',
                style: TextStyle(fontSize: width * 0.04, color: Colors.grey[600]),
              ),
              SizedBox(height: height * 0.02),

              
              Container(
                height: height * 0.1,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: width * 0.22,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: width * 0.1 / 2, 
                            backgroundColor: Colors.orange,
                            child: Icon(Icons.security, color: Colors.white, size: width * 0.1 / 2),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            'Life',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: width * 0.035),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Divider(thickness: 1, color: Colors.grey[400]),

              
              SizedBox(height: height * 0.02),
              Text(
                'UpLearn',
                style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.01),
              Text(
                'Expert-led courses and webinars',
                style: TextStyle(fontSize: width * 0.04, color: Colors.grey[600]),
              ),
              SizedBox(height: height * 0.02),

              
              SizedBox(
                height: height * 0.1,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: width * 0.22,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: width * 0.1 / 2, // Half of the width
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.school, color: Colors.white, size: width * 0.1 / 2),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            'Learn',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: width * 0.035),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Divider(thickness: 1, color: Colors.grey[400]),

             
              SizedBox(height: height * 0.02),
              Text(
                'Quick Links',
                style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.01),
              Text(
                'Stay connected with us on social media',
                style: TextStyle(fontSize: width * 0.04, color: Colors.grey[600]),
              ),
              SizedBox(height: height * 0.02),

             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.youtube_searched_for, color: Colors.red, size: width * 0.08),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.telegram, color: Colors.blue, size: width * 0.08),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.one_x_mobiledata, color: Colors.blueAccent, size: width * 0.08),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.facebook, color: Colors.purple, size: width * 0.08),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
