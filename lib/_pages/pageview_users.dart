import 'package:appwrite/appwrite.dart';
import 'package:appwrite_demo/_appwrite/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageUsers extends StatefulWidget {
  const PageUsers({super.key});

  @override
  State<PageUsers> createState() => _PageUsersState();
}

class _PageUsersState extends State<PageUsers> {
  final pageTitle = 'Users';

  _createAccount() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            backgroundColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.yellow,
                )
              ],
            ),
          );
        });
    try {
      final AuthAPI appwrite = context.read<AuthAPI>();
      await appwrite.createUser(
          email: 'simmonsfrank@gmail.com', password: 'password');
      Navigator.pop(context, true);
      const snackBar = SnackBar(content: Text('Account Created.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on AppwriteException catch (e) {
      Navigator.pop(context);
      showAlert(
          title: 'Account creation unsuccessful', text: e.message.toString());
      print(e);
    }
  }

  void showAlert({required String title, required String text}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            pageTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton.icon(
              onPressed: () {
                _createAccount();
              },
              icon: const Icon(Icons.lock_open),
              label: const Text('Create Account'))
        ],
      ),
    );
  }
}
