import 'package:flutter/material.dart';
import 'package:flutter_task3/screens/task_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final String name;
  const WelcomeScreen({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                heightFactor: 30,
                child: Text(
                  'add new tasks',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: FloatingActionButton(
                        backgroundColor: Color(0xFF15B86C),
                        foregroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskScreen(),
                            ),
                          );
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
