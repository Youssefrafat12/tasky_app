import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 3),
                  child: Text(
                    'Task Name',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _taskNameController,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF282828),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Finish UI design for login screen',
                    hintStyle: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 3),
                  child: Text(
                    'Task Description',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _taskDescriptionController,
                  maxLines: 8,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF282828),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText:
                        'Finish onboarding UI and hand off to devs by Thursday.',
                    hintStyle: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      'High Priority',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(width: 190),
                    Switch(
                      activeTrackColor: Color(0xFF15B86C),
                      activeColor: Colors.white,
                      value: _isSwitched,
                      onChanged: (value) {
                        setState(() {
                          _isSwitched = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 200),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      backgroundColor: Color(0xFF15B86C),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Add Task',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
