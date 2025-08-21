import 'package:flutter/material.dart';
import 'package:flutter_task3/models/task.dart';
import 'package:flutter_task3/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  bool _isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: const Text('New Task'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Task Name',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _taskNameController,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter a task name'
                      : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF282828),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Finish UI design for login screen',
                    hintStyle: const TextStyle(color: Colors.white54),
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  'Task Description',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _taskDescriptionController,
                  maxLines: 6,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter a task description'
                      : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF282828),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText:
                        'Finish onboarding UI and hand off to devs by Thursday.',
                    hintStyle: const TextStyle(color: Colors.white54),
                  ),
                ),

                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      'High Priority',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    Switch(
                      activeTrackColor: const Color(0xFF15B86C),
                      activeColor: Colors.white,
                      value: _isHighPriority,
                      onChanged: (value) {
                        setState(() {
                          _isHighPriority = value;
                        });
                      },
                    ),
                  ],
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF15B86C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: Text(
                      'Add Task',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final task = Task(
                          name: _taskNameController.text,
                          description: _taskDescriptionController.text,
                          highPriority: _isHighPriority,
                        );

                        Provider.of<TaskProvider>(
                          context,
                          listen: false,
                        ).addTask(task);

                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
