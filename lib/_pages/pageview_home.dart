import 'package:appwrite_demo/_appwrite/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  final pageTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthAPI>().status;
    late final String stateText;

    switch (state) {
      case AuthStatus.unauthenticated:
        stateText = 'Not Authenticated';
        break;
      case AuthStatus.authenticated:
        stateText = 'User Authenticated';
        break;
      default:
        stateText = 'Account not initialized';
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          pageTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(stateText)
      ],
    );
  }
}
