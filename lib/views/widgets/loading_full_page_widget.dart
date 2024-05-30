import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingFullpage extends StatefulWidget {
  final bool isLoading;

  const LoadingFullpage({super.key, required this.isLoading});

  @override
  State<LoadingFullpage> createState() => _LoadingFullpageState();
}

class _LoadingFullpageState extends State<LoadingFullpage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _animation = IntTween(begin: 0, end: 30).animate(_controller);
  }

  @override
  void didUpdateWidget(LoadingFullpage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isLoading) {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        String dots = '';
        for (int i = 0; i < _animation.value; i++) {
          dots += '.';
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tinggal-in',
              style: GoogleFonts.firaSans(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              dots,
              style: GoogleFonts.firaSans(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
            )
          ],
        );
      },
    );
  }
}
