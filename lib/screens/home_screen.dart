import 'package:firebase/data/repo.dart';
import 'package:firebase/main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              AuthRepo.getUserData();
            },
            icon: Icon(Icons.eighteen_mp),
          ),
        ],
      ),
    );
  }
}
