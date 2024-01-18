import 'package:flutter/material.dart';
import 'package:sign_in/cabinet.dart';
import 'package:sign_in/sign_up_page.dart';
import 'package:sign_in/tools/databass.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sign_in/tools/hive_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingControllerEmailOrPhone =
      TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  HiveRepo hiveRepo = HiveRepo();
  Map<String, String> mapList = {};
  List<String> namesList = [];

  @override
  void initState() {
    namesList = hiveRepo.getNames();
    mapList = hiveRepo.getMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Container(
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: textEditingControllerEmailOrPhone,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      hintText: "Enter gmail",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Container(
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: textEditingControllerPassword,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      hintText: "Enter password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  mapList.forEach((key, value) {
                    print("key: $key , value $value");
                  });

                  if (textEditingControllerPassword.text.isEmpty &&
                      textEditingControllerEmailOrPhone.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("gmail and password empty"),
                      duration: Duration(seconds: 1),
                    ));
                    return;
                  } else if (textEditingControllerPassword.text.isEmpty ||
                      textEditingControllerEmailOrPhone.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("gmail or password empty"),
                      duration: Duration(seconds: 1),
                    ));
                    return;
                  }

                  bool t = false;
                  int index = 0;
                  int n = 0;

                  mapList.forEach((key, value) {
                    if (key == textEditingControllerPassword.text &&
                        value == textEditingControllerEmailOrPhone.text) {
                      index = n;
                      t = !t;
                    } else
                      n++;
                  });
                  if (t) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cabinet(
                                  name: namesList[index],
                                  gmail: textEditingControllerEmailOrPhone.text,
                                  password: textEditingControllerPassword.text,
                                )));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("gmail or password error"),
                      duration: Duration(seconds: 1),
                    ));
                  }
                },
                child: Text("Sign in")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                  setState(() {
                    mapList = hiveRepo.getMap();
                    namesList = hiveRepo.getNames();
                  });
                },
                child: Text("Sign up")),
          ],
        ),
      ),
    ));
  }
}
