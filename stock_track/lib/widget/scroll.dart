import 'package:flutter/material.dart';

class ScrollingTicker extends StatefulWidget {
  final List<Map<String, String>> items;
  final double scrollSpeed;

  const ScrollingTicker({
    required this.items,
    this.scrollSpeed = 10.0, // Default to a slower speed
  });

  @override
  _ScrollingTickerState createState() => _ScrollingTickerState();
}

class _ScrollingTickerState extends State<ScrollingTicker> {
  late ScrollController _scrollController;
  late double _scrollPosition;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollPosition = 0.0;
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() {
    final double maxScrollExtent = _scrollController.position.maxScrollExtent;
    final double initialScrollExtent = _scrollController.position.minScrollExtent;
    
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollPosition += widget.scrollSpeed;
      if (_scrollPosition >= maxScrollExtent) {
        _scrollPosition = initialScrollExtent;
      }
      _scrollController.animateTo(
        _scrollPosition,
        duration: const Duration(milliseconds: 50),
        curve: Curves.linear,
      ).then((_) => _startScrolling());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(20), 
                border: Border.all(color: Colors.grey), 
              ),
              child: Row(
                children: [
                  Text(
                    item['text']!,
                    style: const TextStyle(
                      fontSize: 15.0, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black, 
                    ),
                  ),
                  const SizedBox(width: 8.0), 
                  Text(
                    item['value']!,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: item['value']!.contains('\u2193') ? Colors.red : Colors.green, 
                    ),
                  ),
                  const SizedBox(width: 8.0), 
                  Text(
                    item['percentage']!,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: item['percentage']!.contains('-') ? Colors.red : Colors.green, 
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
