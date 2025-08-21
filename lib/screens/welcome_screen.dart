import 'package:flutter/material.dart';
import 'package:flutter_task3/models/task.dart';
import 'package:flutter_task3/screens/task_screen.dart';
import 'package:flutter_task3/providers/task_provider.dart';
import 'package:provider/provider.dart';

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
    // TODO: Add navigation logic for each tab if needed
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

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
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                maxLines: 2,
                'One task at a time. One step closer.',
                style: TextStyle(fontSize: 15, color: Colors.white70),
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
            ),
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
                  'My Tasks',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: taskProvider.tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'No tasks yet. Add one!',
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      itemCount: taskProvider.tasks.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final task = taskProvider.tasks[index];
                        return ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              taskProvider.toggleTaskCompletion(index);
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
                          title: Text(
                            task.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Text(
                            task.description,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: const Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
      ),
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
