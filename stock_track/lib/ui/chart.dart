import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:stock_track/core/provider/StockProvider.dart';

class StockChartScreen extends StatefulWidget {
  StockChartScreen();

  @override
  _StockChartScreenState createState() => _StockChartScreenState();
}

class _StockChartScreenState extends State<StockChartScreen> {
  String _selectedOption = 'Weekly'; 
  String _type = "Date";

  @override
  Widget build(BuildContext context) {
    final STOCK = Provider.of<Stockprovider>(context);
    List<FlSpot> spots = [];
    List<String> dates = [];

    Map<String, dynamic> dataToUse;
    if (_selectedOption == 'Weekly') {
      setState(() {
        _type = "Date";
      });
      final sortedDates = STOCK.SelectWeek.keys.toList()..sort((a, b) => b.compareTo(a));
      final recentDates = sortedDates.take(10).toList().reversed.toList();

      int index = 0;
      for (var date in recentDates) {
        final closePrice = double.parse(STOCK.SelectWeek[date]['4. close']);
        spots.add(FlSpot(index.toDouble(), closePrice));
        dates.add(date);
        index++;
      }
    } else {
      setState(() {
        _type = "Time";
      });
      final sortedDates = STOCK.SelectTime.keys.toList()..sort((a, b) => b.compareTo(a));
      final recentDates = sortedDates.take(10).toList().reversed.toList();

      int index = 0;
      for (var date in recentDates) {
        final closePrice = double.parse(STOCK.SelectTime[date]['4. close']);
        spots.add(FlSpot(index.toDouble(), closePrice));
        dates.add(date);
        index++;
      }
    }

    return WillPopScope(
      onWillPop: () async {
        STOCK.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${STOCK.SelectedSymbol} - ${_selectedOption} Chart'),
          actions: [
            DropdownButton<String>(
              value: _selectedOption,
              items:const [
                DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                DropdownMenuItem(value: 'Today', child: Text('Today')),
              ],
              onChanged: (value) {
                setState(() {
                  dates.clear();
                  spots.clear();
                  _selectedOption = value!;
                });
              },
            ),
          ],
        ),
        body: spots.isNotEmpty && dates.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 1.3, 
                    ),
                    child: LineChart(
                      LineChartData(
                        gridData:const FlGridData(show: true),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 60, 
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                String date = index < dates.length ? dates[index] : '';
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: RotatedBox(
                                    quarterTurns: 1, 
                                    child: Text(
                                      date,
                                      style:const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toStringAsFixed(2), 
                                  style:const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.left, 
                                );
                              },
                              reservedSize: 40, 
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        minX: 0,
                        maxX: spots.length.toDouble() - 1,
                        minY: spots.map((e) => e.y).reduce((a, b) => a < b ? a : b) - 10,
                        maxY: spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 10,
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 4,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue.withOpacity(0.3), 
                            ),
                            dotData:const FlDotData(show: false), 
                            aboveBarData: BarAreaData(show: false),
                            gradient:const LinearGradient(
                              colors: [Colors.blue, Colors.blueAccent],
                              stops: [0.2, 0.9],
                            ),
                          ),
                        ],
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                return LineTooltipItem(
                                  '\$${spot.y.toStringAsFixed(2)}', 
                                  TextStyle(color: Colors.white),
                                  children: [
                                    TextSpan(
                                      text: ' $_type: ${dates[spot.spotIndex.toInt()]}',
                                      style: TextStyle(fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                );
                              }).toList();
                            },
                          ),
                          handleBuiltInTouches: true,
                        ),
                        clipData: FlClipData.all(),
                        showingTooltipIndicators: spots.map((e) {
                          return ShowingTooltipIndicators([
                            LineBarSpot(
                              LineChartBarData(spots: spots),
                              0,
                              e,
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
