import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:homework/utils/point.dart';

import 'models/incoming_data_model.dart';

class PreviewResultScreen extends StatelessWidget {
  const PreviewResultScreen({Key? key,
    required this.roadPoint,
    required this.incomingData,
    required this.answer})
      : super(key: key);
  final List<Point> roadPoint;
  final Task incomingData;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: incomingData.field.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (incomingData.field.length + 1) / 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 1),
                itemBuilder: (BuildContext ctx, index) {
                  List<Widget> rowContainers = <Widget>[];
                  for (int i = 0; i < incomingData.field[index].length; i++) {
                    rowContainers.add(
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: getColorCell(
                                incomingData.field[index].substring(i, i + 1),
                                index, i) == Color(0x00ffffff)
                                ? Colors.black
                                : Colors.white),
                            color: getColorCell(incomingData.field[index]
                                .substring(i, i + 1), index, i),
                          ),

                          width: MediaQuery
                              .of(context)
                              .size
                              .width / (incomingData.field.length + 1),
                          height: MediaQuery
                              .of(context)
                              .size
                              .width / (incomingData.field.length + 1),

                          child: Center(
                            child: Text('($index,$i)', style: TextStyle(
                                color: getColorCell(
                                    incomingData.field[index].substring(
                                        i, i + 1), index, i) ==
                                    Color(0x00ffffff) ? Colors.black : Colors
                                    .white),),
                          ),
                        )

                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: rowContainers,
                  );
                }),
          ),
          Center(child: Text(answer)),
        ],
      ),
    );
  }

  Color getColorCell(String inChar, int y, int x) {
    Color color;
    if (inChar == 'X') {
      color = const Color(0xFF000000);
    }
    else {
      final index = roadPoint.indexWhere((element) =>
      element.y == y && element.x == x);

      if (index == -1) {
        color = const Color(0x00ffffff);
      } else if (index == 0) {
        color = const Color(0xFF64FFDA);
      } else if (index == roadPoint.length - 1) {
        color = const Color(0xFF009688);
      }
      else {
        color = const Color(0xFF4CAF50);
      }
    }
    return color;
  }
}
