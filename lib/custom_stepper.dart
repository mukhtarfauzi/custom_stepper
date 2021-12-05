library custom_stepper;

import 'package:flutter/material.dart';

class _StepInherited extends InheritedWidget {
  const _StepInherited({
    Key? key,
    required Widget child,
    required this.size,
    required this.direction,  }) : super(key: key, child: child);

  final double size;
  final Axis direction;

  static _StepInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_StepInherited>();
  }

  @override
  bool updateShouldNotify(_StepInherited oldWidget) {
    return oldWidget.size != size;
  }
}

class StepCircle extends StatelessWidget {
  final Color? color;
  final Color? activeColor;
  final Color? outlineColor;
  final Color? activeBackgroundColor;
  final Color? inactiveBackgroundColor;
  final String label;
  final Widget? content;
  final bool isActive;

  const StepCircle({
    Key? key,
    this.color,
    this.activeColor,
    this.outlineColor,
    this.activeBackgroundColor,
    this.inactiveBackgroundColor,
    required this.label,
    this.content,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inheritance = _StepInherited.of(context);
    final _color = color ?? Theme.of(context).colorScheme.primary;
    final _activeColor =
        activeColor ?? Theme.of(context).scaffoldBackgroundColor;
    final _size = inheritance?.size ?? 15;
    final _direction = inheritance?.direction ?? Axis.horizontal;
    final _backgroundColor =
        outlineColor ?? Theme.of(context).colorScheme.primaryVariant;
    final _activeBackgroundColor =
        activeBackgroundColor ?? Theme.of(context).colorScheme.primary;
    final _inactiveBackgroundColor =
        inactiveBackgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? _activeColor : _color,
                fontSize: _size,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          width: _size * 2.14,
          height: _size * 2.14,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                color: isActive ? _activeBackgroundColor : _backgroundColor,
                width: 1),
            color:
            isActive ? _activeBackgroundColor : _inactiveBackgroundColor,
            borderRadius: BorderRadius.circular(_size * 2.14),
          ),
        ),
        content != null
            ? _direction == Axis.horizontal
                ? Padding(
                    padding: EdgeInsets.only(top: _size * 2.14),
                    child: content,
                  )
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: _size * 2.14),
                      child: content,
                    ),
                  )
            : Container(),
      ],
    );
  }
}

class Path {
  final double? width;
  final Color? color;

  Path({this.width, this.color});
}

class CustomStepper extends StatelessWidget {
  final Axis direction;
  final List<StepCircle> steps;
  final double size;
  final Path path;
  final bool scrollable;
  const CustomStepper({
    Key? key,
    // TODO: For now only available in this [Axis.horizontal] direction
    this.direction = Axis.horizontal,
    required this.steps,
    this.size = 15,
    required this.path,
    this.scrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _StepInherited(
      size: size,
      direction: direction,
      child: scrollable
          ? ListView.builder(
              scrollDirection: direction,
              itemCount: steps.length,
              itemBuilder: (context, position) => Stack(
                children: <Widget>[
                  Positioned(
                    top: direction == Axis.horizontal
                        ? size * 2.14 / 2 - 5 / 2
                        : 0,
                    bottom: direction == Axis.horizontal ? null : 0,
                    left: direction == Axis.horizontal
                        ? 0
                        : size * 2.14 / 2 - 5 / 2,
                    right: direction == Axis.horizontal ? 0 : null,
                    height: direction == Axis.horizontal ? path.width : null,
                    width: direction == Axis.horizontal ? null : path.width,
                    child: Container(
                      color: path.color,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: Text(
                            steps[position].label,
                            style: TextStyle(
                              color: steps[position].color,
                              fontSize: size,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          width: size * 2.14,
                          height: size * 2.14,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: steps[position].outlineColor,
                            borderRadius: BorderRadius.circular(size * 2.14),
                          ),
                        ),
                        steps[position].content != null
                            ? direction == Axis.horizontal
                                ? Padding(
                                    padding: EdgeInsets.only(top: size * 2.14),
                                    child: steps[position].content,
                                  )
                                : Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: size * 2.14),
                                      child: steps[position].content,
                                    ),
                                  )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...steps.asMap().keys.map(
                  (index) {
                    if (index == (steps.length - 1)) {
                      return steps[index];
                    }

                    return Expanded(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: direction == Axis.horizontal
                                ? size * 2.14 / 2 - 5 / 2
                                : 0,
                            bottom: direction == Axis.horizontal ? null : 0,
                            left: direction == Axis.horizontal
                                ? 0
                                : size * 2.14 / 2 - 5 / 2,
                            right: direction == Axis.horizontal ? 0 : null,
                            height: direction == Axis.horizontal
                                ? path.width
                                : null,
                            width: direction == Axis.horizontal
                                ? null
                                : path.width,
                            child: Container(
                              color: path.color,
                            ),
                          ),
                          steps[index],
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
    );
  }
}
