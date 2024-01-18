import 'package:flutter/material.dart';
import 'package:sign_in/tools/hive_repo.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameT = TextEditingController();
  TextEditingController gmailT = TextEditingController();
  TextEditingController passwordT = TextEditingController();
  TextEditingController rPasswordT = TextEditingController();
  Map<String, String> accountMap = {};
  HiveRepo hiveRepo = HiveRepo();
  List<String> nameList = [];
  int b = 10;

  @override
  void initState() {
    accountMap = hiveRepo.getMap();
    nameList = hiveRepo.getNames();
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
            helper(
              "Enter Name",
              nameT,
            ),
            SizedBox(
              height: 20,
            ),
            helper(
              "Enter Gmail or Phone Number",
              gmailT,
            ),
            SizedBox(
              height: 20,
            ),
            helper(
              "Enter Password",
              passwordT,
            ),
            SizedBox(
              height: 20,
            ),
            helper(
              "Repeat Password",
              rPasswordT,
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  if (check()) {
                    if (passwordT.text == rPasswordT.text) {
                      nameList.add(nameT.text);
                      accountMap[passwordT.text] = gmailT.text;
                      hiveRepo.safeName(nameList);
                      hiveRepo.safeMap(accountMap);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("kritgan kodiz 2 hil bopqoldi"),
                        duration: Duration(seconds: 1),
                      ));
                      return;
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("name, gmail or password"),
                      duration: Duration(seconds: 1),
                    ));
                    return;
                  }

                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          height: 250,
                          width: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("account is created, go to sign in page"),
                              SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      nameT.clear();
                                      gmailT.clear();
                                      passwordT.clear();
                                      rPasswordT.clear();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("go back"))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text("Sign up")),
          ],
        ),
      ),
    ));
  }

  bool check() =>
      (nameT.text).isNotEmpty &&
      (gmailT.text).isNotEmpty &&
      (passwordT.text).isNotEmpty &&
      (rPasswordT.text).isNotEmpty;

  Widget helper(String str, TextEditingController text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Container(
        width: double.infinity,
        height: 50,
        child: TextField(
          controller: text,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5),
              hintText: str,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}
