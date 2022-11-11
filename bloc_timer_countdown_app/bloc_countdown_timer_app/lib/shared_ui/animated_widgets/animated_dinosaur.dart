import 'package:flutter/material.dart';

class AnimatedDinosaur extends StatefulWidget {
  const AnimatedDinosaur({Key? key, required this.iconData}) : super(key: key);
  final IconData iconData;
  static final _AnimatedDinosaurState _state = _AnimatedDinosaurState();

  @override
  // ignore: no_logic_in_create_state
  State<AnimatedDinosaur> createState() => _state;

  void flip() {
    _state.flip();
  }
}

class _AnimatedDinosaurState extends State<AnimatedDinosaur>
    with TickerProviderStateMixin {
  late final AnimationController _flipController;
  late final AnimationController _jumpController;
  late final Animation<double> _rotationAnimation = CurvedAnimation(
    parent: _flipController,
    curve: Curves.linear,
    reverseCurve: Curves.linear,
  );
  late final Animation<Offset> _jumpAnimation = Tween<Offset>(
          begin: Offset.zero, end: const Offset(0, -1))
      .animate(CurvedAnimation(parent: _jumpController, curve: Curves.linear));

  @override
  void initState() {
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _jumpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  void flip() {
    _flipController.forward();
    _jumpController.forward().then(((value) => _jumpController.reverse()));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _jumpAnimation,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: Icon(widget.iconData),
      ),
    );
  }
}
