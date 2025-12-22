import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final _controller = TextEditingController();
  String _message = 'Enter PIN (1234)';

  void _checkPin(String pin) async {
    // Stub logic: PIN is always 1234
    if (pin == '1234') {
      context.go('/dashboard'); 
    } else {
      setState(() => _message = 'Incorrect PIN');
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_message, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 32),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                onChanged: (val) {
                  if (val.length == 4) _checkPin(val);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'PIN',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
