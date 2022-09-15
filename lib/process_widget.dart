import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homework/result_screen.dart';
import 'package:homework/utils/find_shortest_road.dart';
import 'package:homework/utils/http.dart';
import 'package:homework/utils/point.dart';
import 'package:homework/utils/shared_preference_facade.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'models/incoming_data_model.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({Key? key, required this.link}) : super(key: key);
  final String link;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {

  void sendResult(List<List<Point>?> data) async{
    final body = {};
    await Http().post(url: widget.link, body: body);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ResultScreen(listResult: data,)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process Screen'),
      ),
      body: baseBuilder(context),
    );

  }

  Widget baseBuilder(context) {
    return Column(
      children: [
        const ProgressBar(),
        StreamBuilder<dynamic>(
          initialData: [],
          stream: _longOperation(context, widget.link),
          builder: (context, snapshot) {
            final isLoadingData = snapshot.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  isLoadingData == null
                      ? const SizedBox.shrink()
                      : const Text(
                          'All calculations has finished, you can send your results to server', textAlign: TextAlign.center,),

                  isLoadingData == null ? const SizedBox.shrink() :
                      ElevatedButton(
                          onPressed: ()=> sendResult(isLoadingData!),
                          child: const Text('Send results to server'))
                ],
              ),
            );
          },
        ),
      ],
    );
  }


  Stream<dynamic> _longOperation(BuildContext context, String url) async* {
    yield null;
    final task = await Http().get(url);
    if (task != null){
      GetIt.I<SharedPreferencesFacade>().set('incomingData', jsonEncode(task));
        final result = findShortestRoad(IncomingData.fromJson(task).data!);
        yield result;
      } else {
      yield null;

    }

  }



}
class ProgressBar extends StatefulWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  int percent = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timerStart();
  }
  timerStart(){
    timer = Timer.periodic(const Duration(milliseconds:50),(_){
      setState(() {
        percent+=1;
        if(percent >= 100){
          timer?.cancel();
          // percent=0;
        }
      });
    });
  }
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularPercentIndicator(
        animation: false,
        percent: percent/100,
        center: Text(
          "$percent%",
          style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        radius: 70.0,
        lineWidth: 20.0,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: Colors.purple,
      ),
    );
  }
}

