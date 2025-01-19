import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'expenses_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Simulasi data pengguna (array sederhana)
  List<Map<String, String>> users = [
    {'username': 'admin', 'password': 'admin123'}
  ];

  void login() {
    String username = usernameController.text;
    String password = passwordController.text;

    // Validasi username dan password
    bool isValidUser = users.any((user) =>
        user['username'] == username && user['password'] == password);

    if (isValidUser) {
      // Navigasi ke halaman Expenses jika login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ExpensesScreen(),
        ),
      );
    } else {
      // Tampilkan notifikasi jika login gagal
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid username or password!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen(users: users)),
                );
              },
              child: Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
