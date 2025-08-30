import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task3/screens/edit_task_screen.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import 'task_screen.dart';

class WelcomeScreen extends StatefulWidget {
  final String name;
  const WelcomeScreen({super.key, required this.name});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List _filterTasks(TaskState state) {
    if (_selectedIndex == 1) {
      // To Do
      return state.tasks.where((task) => !task.isDone).toList();
    } else if (_selectedIndex == 2) {
      // Completed
      return state.tasks.where((task) => task.isDone).toList();
    }
    // Home (All)
    return state.tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color(0xFF1E1E1E),
          elevation: 0,
          leadingWidth: 80,
          leading: const Padding(
            padding: EdgeInsets.only(left: 16, top: 8, right: 8),
            child: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Evening, ${widget.name}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                maxLines: 2,
                'One task at a time. One step closer.',
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundColor: Color(0xFF282828),
                child: Icon(Icons.light_mode, color: Colors.white),
              ),
              tooltip: 'Theme',
            ),
            IconButton(
              onPressed: () {
                context.read<TaskBloc>().add(ClearAllTasksEvent());
              },
              icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
              tooltip: 'Clear All Tasks',
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _selectedIndex == 0
                      ? 'All Tasks'
                      : _selectedIndex == 1
                      ? 'To Do'
                      : _selectedIndex == 2
                      ? 'Completed'
                      : 'Profile',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  final filteredTasks = _filterTasks(state);

                  if (_selectedIndex == 3) {
                    return const Center(
                      child: Text(
                        'Profile Screen Coming Soon',
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    );
                  }

                  if (filteredTasks.isEmpty) {
                    return const Center(
                      child: Text(
                        'No tasks here. Add one!',
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: filteredTasks.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            final originalIndex = state.tasks.indexOf(task);
                            context.read<TaskBloc>().add(
                              ToggleTaskCompletionEvent(originalIndex),
                            );
                          },
                          child: Icon(
                            task.isDone
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: task.isDone ? Colors.green : Colors.grey,
                          ),
                        ),
                        tileColor: const Color(0xFF282828),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Row(
                          children: [
                            if (task.highPriority)
                              const Icon(
                                Icons.priority_high,
                                color: Colors.red,
                                size: 18,
                              ),
                            if (task.highPriority) const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                task.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  decoration: task.isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          task.description,
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: PopupMenuButton<String>(
                          color: const Color(0xFF282828),
                          onSelected: (value) {
                            final originalIndex = state.tasks.indexOf(task);
                            if (value == 'delete') {
                              context.read<TaskBloc>().add(
                                RemoveTaskEvent(originalIndex),
                              );
                            } else if (value == 'edit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditTaskScreen(
                                    index: originalIndex,
                                    task: task,
                                  ),
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedIndex != 3
          ? FloatingActionButton.extended(
              backgroundColor: const Color(0xFF15B86C),
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskScreen()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add new task'),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E1E),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        selectedItemColor: const Color(0xFF15B86C),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'To Do'),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
