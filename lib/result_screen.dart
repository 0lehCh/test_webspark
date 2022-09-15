
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homework/preview_result_screen.dart';
import 'package:homework/utils/point.dart';
import 'package:homework/utils/shared_preference_facade.dart';

import 'models/incoming_data_model.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key, required this.listResult}) : super(key: key);
final List<List<Point>?> listResult;

  @override
  Widget build(BuildContext context) {
    final storage = GetIt.I<SharedPreferencesFacade>();
    List<Task>? incomingData = IncomingData.fromJson(jsonDecode(storage.get('incomingData'))).data;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result list screen"),
      ),
      body: ListView.builder(
        itemCount: listResult.length,
          itemBuilder: (BuildContext context, index){
          String name ='';
          for(var item in listResult[index]!){
            if(item != listResult[index]!.last) {name += '(${item.y},${item.x}) =>';
          } else {
              name += '(${item.y},${item.x})';
            }
          }
            return
                InkWell(
                  onTap: ()=> Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PreviewResultScreen(roadPoint: listResult[index]!, incomingData: incomingData![index], answer: name,)),
                  ),
                  child: Card(
                    child: Container(
                        height: 50,
                        color: Colors.white24,
                        child: Center(child: Text(name))),
                  ),
                );
          }),
    );
  }
}
