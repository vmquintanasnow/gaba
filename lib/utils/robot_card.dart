import 'package:flutter/material.dart';
import 'package:screening/utils/robot_model.dart';

class RobotCard extends StatefulWidget {
  const RobotCard({Key key, this.robot}) : super(key: key);

  final Robot robot;

  @override
  _RobotCardState createState() => _RobotCardState();
}

class _RobotCardState extends State<RobotCard> with TickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      lowerBound: 0.8,
      value: 1,
      upperBound: 1.1,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = _controller.drive(Tween<double>(
      end: 1.0,
      begin: 0.8,
    ));
    _controller.animateTo(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.animateTo(0.8);
      },
      onTapCancel: () {
        _controller.animateTo(1);
      },
      onHover: (isHover) {
        if (isHover) {
          _controller.animateTo(1.2);
        } else {
          _controller.animateTo(1);
        }
      },
      child: ScaleTransition(
        scale: _animation,
        child: Card(
          margin: const EdgeInsets.all(10),
          color: const Color(0xff9eebcf),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 5,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(
                    'https://robohash.org/${widget.robot.id}?200x200',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    widget.robot.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                ),
                Text(
                  widget.robot.email,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

