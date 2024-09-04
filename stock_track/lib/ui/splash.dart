import 'package:flutter/material.dart';
import 'package:stock_track/main.dart';
import 'package:stock_track/ui/route.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textPositionAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _imagePositionAnimation;
  late Animation<double> _imageScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _textPositionAnimation = Tween<double>(begin: 0, end: -200).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.easeInOut)),
    );

    _textOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.5, curve: Curves.easeInOut)),
    );

    _imagePositionAnimation = Tween<double>(begin: 300, end: -100).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.8, curve: Curves.easeInOut)),
    );

    _imageScaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.8, 1.0, curve: Curves.easeInOut)),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => StockListScreen()), 
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[600],
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              
              Align(
                alignment: Alignment(0, _textPositionAnimation.value / MediaQuery.of(context).size.height),
                child: Opacity(
                  opacity: _textOpacityAnimation.value,
                  child: Text(
                    'STOCK TRACK',
                    style: TextStyle(
                      fontSize: 42.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 3.0,
                          color: Colors.grey.shade500,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 1.0),
                child: Transform.translate(
                  offset: Offset(0, _imagePositionAnimation.value),
                  child: Opacity(
                    opacity: _controller.value >= 0.6 ? 1.0 : 0.0,
                    child: ScaleTransition(
                      scale: _imageScaleAnimation,
                      child: Image.asset(
                        'assets/stock.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
