import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../models/task.dart';

class EditTaskScreen extends StatefulWidget {
  final int index;
  final Task task;

  const EditTaskScreen({super.key, required this.index, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late bool _highPriority;

  @override
  void initState() {
    super.initState();
    _name = widget.task.name;
    _description = widget.task.description;
    _highPriority = widget.task.highPriority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Task Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value ?? '',
              ),
              SwitchListTile(
                title: const Text('High Priority'),
                value: _highPriority,
                onChanged: (val) => setState(() => _highPriority = val),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<TaskBloc>().add(
                      EditTaskEvent(
                        widget.index,
                        widget.task.copyWith(
                          name: _name,
                          description: _description,
                          highPriority: _highPriority,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
