import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task3/screens/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('images/Vector.svg'),
                          const SizedBox(width: 16),
                          Text(
                            'Tasky',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 116),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome To Tasky',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset('images/waving-hand.svg'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your productivity journey starts here.',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 24),
                      Center(child: SvgPicture.asset('images/pana.svg')),
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 3,
                                ),
                                child: Text(
                                  'Full Name',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _nameController,
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter a valid name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFF282828),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'e.g. Sarah Khalid',
                                ),
                              ),
                              const SizedBox(height: 24),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width,
                                      40,
                                    ),
                                    backgroundColor: const Color(0xFF15B86C),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WelcomeScreen(
                                            name: _nameController.text.trim(),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Let's Get Started",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
