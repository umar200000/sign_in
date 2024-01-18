import 'package:flutter/material.dart';

class Cabinet extends StatefulWidget {
  final String name;
  final String gmail;
  final String password;
  const Cabinet(
      {super.key,
      required this.name,
      required this.gmail,
      required this.password});

  @override
  State<Cabinet> createState() => _CabinetState();
}

class _CabinetState extends State<Cabinet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Text(
            "Name: ${widget.name}\n Gmail: ${widget.gmail}\n Password: ${widget.password}"),
      ),
    ));
  }
}
