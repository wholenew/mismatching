import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../constants/doubles.dart';

class Indicator extends StatefulWidget {
  const Indicator({Key? key, required this.tabController}) : super(key: key);

  final TabController tabController;
  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  void dispose() {
    widget.tabController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.tabController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    final decorator = DotsDecorator(
      activeColor: Colors.white,
      size: Size.square(10.0),
      activeSize: Size.square(16.0),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
    return Container(
      height: tabBarHeight,
      color: Colors.red,
      child: DotsIndicator(
        dotsCount: widget.tabController.length,
        position: widget.tabController.index.toDouble(),
        axis: Axis.horizontal,
        decorator: decorator,
      ),
    );
  }
}
