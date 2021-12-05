import 'package:flutter/material.dart';
import 'package:custom_stepper/custom_stepper.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(title: 'Steps'),
    ));

class Home extends StatelessWidget {
  final String title;
  Home({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(10),
        child: CustomStepper(
          direction: Axis.horizontal,
          size: 12.0,
          path: Path(color: Colors.lightBlue.shade200, width: 1.0),
          steps: const [
            StepCircle(
              0,
              label: '1',
            ),
            StepCircle(
              1,
              label: '2',
            ),
            StepCircle(
              2,
              label: '3',
            ),StepCircle(
              3,
              label: '4',
            ),StepCircle(
              4,
              label: '5',
            ),StepCircle(
              5,
              label: '6',
            ),StepCircle(
              6,
              label: '7',
            ),
          ],
        ),
      ),
    );
  }
}
