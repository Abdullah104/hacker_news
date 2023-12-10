import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoadingInfo extends StatefulWidget {
  const LoadingInfo(this._isLoading, {Key? key}) : super(key: key);

  final Stream<bool> _isLoading;

  @override
  State<LoadingInfo> createState() => _LoadingInfoState();
}

class _LoadingInfoState extends State<LoadingInfo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget._isLoading,
      builder: (context, snapshot) {
        _animationController
            .forward()
            .then((value) => _animationController.reverse());

        return FadeTransition(
          opacity: Tween(begin: 0.5, end: 1.0).animate(
            CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
          ),
          child: const Icon(FontAwesomeIcons.hackerNews),
        );
      },
    );
  }
}
