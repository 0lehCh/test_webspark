import 'package:flutter/material.dart';
import 'package:homework/process_widget.dart';

import 'get_it.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await getIt().allReady();

  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Test Webspark'),
          ),
          body: const GetApiWidget(),
        ));
  }
}

class GetApiWidget extends StatefulWidget {
  const GetApiWidget({Key? key}) : super(key: key);

  @override
  State<GetApiWidget> createState() => _GetApiWidgetState();
}

class _GetApiWidgetState extends State<GetApiWidget> {
  bool isErrorLink = false;
  TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          isErrorLink
              ? const Text('Set valid API base URL in order to continue')
              : const SizedBox.shrink(),
          TextField(
            controller: linkController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              errorMaxLines: 1,
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.red,
                  )),
              hintText: 'API link',
              hintStyle: TextStyle(
                  color: Colors.black54.withOpacity(0.3), fontSize: 14),
              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    color: Colors.black38,
                  )),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    color: Colors.black54,
                  )),
              focusColor: Colors.black26,
            ),
          ),
          ElevatedButton(
              onPressed: () => {
                if (linkController.value.text!='https://flutter.webspark.dev/flutter/api') {
                  setState((){isErrorLink=true;})
                } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProcessScreen(link: linkController.value.text)),
                  ),}},
              child: const Center(child: Text('Start counting process')))
        ],
      ),
    );
  }
}
