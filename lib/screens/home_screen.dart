import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task3/screens/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

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
                          SizedBox(width: 16),
                          Text(
                            'Tasky',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 116),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome To Tasky',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(width: 8),
                          SvgPicture.asset('images/waving-hand.svg'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Your productivity journey starts here.',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(height: 24),
                      Center(child: SvgPicture.asset('images/pana.svg')),
                      SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: 3),
                                child: Text(
                                  'Full Name',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                controller: _nameController,
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter a valid name';
                                  }
                                  if (value.toLowerCase().trim() != 'youssef') {
                                    return 'Please enter your name';
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
                                  hintText: 'e.g. Sarah Khalid',
                                ),
                              ),
                              SizedBox(height: 24),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width,
                                      40,
                                    ),
                                    backgroundColor: Color(0xFF15B86C),
                                  ),
                                  onPressed: () {
                                    if (_formkey.currentState?.validate() ??
                                        false) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WelcomeScreen(
                                            name: _nameController.text,
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
                      SizedBox(height: 16), // just a little breathing room
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
