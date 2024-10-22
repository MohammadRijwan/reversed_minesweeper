import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static String route = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        final _vm = ref.watch(loginVmProvider);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome to Reversed Minesweeper',
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Login to your account',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                      ),
                ),
              ),
              SizedBox(height: size.height * 0.15),
              InkWell(
                onTap: () {
                  _vm.onLogin(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 60,
                    width: size.width * 0.6,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(6.0)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset('assets/google_icon.png')),
                        ),
                        Text(
                          'Google Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      }),
    );
  }
}
