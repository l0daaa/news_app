import 'package:flutter/material.dart';

class AnimatedCurvedNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AnimatedCurvedNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<AnimatedCurvedNavigationBar> createState() => _AnimatedCurvedNavigationBarState();
}

class _AnimatedCurvedNavigationBarState extends State<AnimatedCurvedNavigationBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _endingIndex = 0;
  double _pos = 0;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, value: widget.selectedIndex.toDouble());
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
      });
    });
    _endingIndex = widget.selectedIndex;
    _pos = widget.selectedIndex.toDouble();
  }
  
  @override
  void didUpdateWidget(AnimatedCurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _endingIndex = widget.selectedIndex;
      _animationController.animateTo(
        _endingIndex.toDouble(),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Container(
      height: 90.0,
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: CustomPaint(
                  size: Size(size.width, 60.0),
                  painter: NavCustomPainter(
                      _pos, 2, const Color(0xFF09162A), Directionality.of(context)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30.0,
            left: Directionality.of(context) == TextDirection.rtl
                ? null
                : _pos * (size.width / 2) + (size.width / 2) / 2 - 28.0,
            right: Directionality.of(context) == TextDirection.rtl
                ? _pos * (size.width / 2) + (size.width / 2) / 2 - 28.0
                : null,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 56.0,
                height: 56.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: Icon(
                  _endingIndex == 0 ? Icons.home : Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 60.0,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildIcon(0, Icons.home, size),
                  _buildIcon(1, Icons.search, size),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(int index, IconData icon, Size size) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onItemTapped(index);
      },
      child: Container(
        height: 60,
        width: size.width / 2,
        alignment: Alignment.center,
        child: _endingIndex == index ? const SizedBox() : Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }
}

class NavCustomPainter extends CustomPainter {
  double loc;
  double s;
  Color color;
  TextDirection textDirection;

  NavCustomPainter(double startingLoc, int itemsLength, this.color, this.textDirection) : loc = 0, s = 0.2 {
    final span = 1.0 / itemsLength;
    double l = startingLoc * span + (span - s) / 2;
    if (textDirection == TextDirection.rtl) {
      loc = 0.8 - l;
    } else {
      loc = l;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * loc, 0);

    // Create the cutout curve (the dip)
    path.cubicTo(
      size.width * (loc + s * 0.1), 0, 
      size.width * (loc + s * 0.2), size.height * 0.7, 
      size.width * (loc + s * 0.5), size.height * 0.7, 
    );
    path.cubicTo(
      size.width * (loc + s * 0.8), size.height * 0.7, 
      size.width * (loc + s * 0.9), 0, 
      size.width * (loc + s), 0, 
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // We want it to repaint constantly during the animation
  }
}
