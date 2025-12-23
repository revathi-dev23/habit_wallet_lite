import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String _pin = '';
  String _message = 'Enter Secure PIN';
  bool _rememberMe = false;
  final _emailController = TextEditingController(text: 'candidate@interview.com');

  void _handleKeyPress(String key) {
    if (_pin.length < 4) {
      setState(() {
        _pin += key;
        if (_pin.length == 4) _checkPin(_pin);
      });
    }
  }

  void _handleDelete() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _message = 'Enter Secure PIN';
      });
    }
  }

  void _checkPin(String pin) async {
    if (pin == '1234') {
      context.go('/dashboard');
    } else {
      setState(() {
        _pin = '';
        _message = 'Incorrect PIN. Try 1234';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.surface,
              colorScheme.surface.withValues(alpha: 0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Icon(Icons.lock_outline, size: 64, color: colorScheme.primary),
                const SizedBox(height: 24),
                Text(
                  'Habit Wallet',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Semantics(
                    label: 'Email Input',
                    child: TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.7)),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5)),
                        prefixIcon: Icon(Icons.email_outlined, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Semantics(
                  liveRegion: true,
                  child: Text(
                    _message,
                    style: TextStyle(color: _message.contains('Incorrect') ? colorScheme.error : colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                ),
                const SizedBox(height: 24),
                _buildPinDots(colorScheme),
                const SizedBox(height: 16),
                _buildRememberMe(colorScheme),
                const SizedBox(height: 32),
                _buildKeyboard(colorScheme),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMe(ColorScheme colorScheme) {
    return MergeSemantics(
      child: GestureDetector(
        onTap: () => setState(() => _rememberMe = !_rememberMe),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (v) => setState(() => _rememberMe = v ?? false),
              activeColor: colorScheme.primary,
              checkColor: colorScheme.onPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              side: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.2)),
            ),
            Text('Remember Me', style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5), fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildPinDots(ColorScheme colorScheme) {
    return Semantics(
      label: 'Security PIN',
      value: '${_pin.length} digits entered',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final isActive = index < _pin.length;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.1),
              boxShadow: isActive
                  ? [BoxShadow(color: colorScheme.primary.withValues(alpha: 0.5), blurRadius: 10)]
                  : [],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildKeyboard(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          _buildRow(['1', '2', '3'], colorScheme),
          _buildRow(['4', '5', '6'], colorScheme),
          _buildRow(['7', '8', '9'], colorScheme),
          _buildRow([null, '0', 'delete'], colorScheme),
        ],
      ),
    );
  }

  Widget _buildRow(List<String?> keys, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: keys.map((key) {
        if (key == null) return const SizedBox(width: 80, height: 80);
        if (key == 'delete') {
          return IconButton(
            onPressed: _handleDelete,
            tooltip: 'Delete',
            icon: Icon(Icons.backspace_outlined, color: colorScheme.onSurface),
            padding: const EdgeInsets.all(24),
          );
        }
        return _buildKey(key, colorScheme);
      }).toList(),
    );
  }

  Widget _buildKey(String label, ColorScheme colorScheme) {
    return Semantics(
      label: label,
      button: true,
      child: InkWell(
        onTap: () => _handleKeyPress(label),
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(fontSize: 28, color: colorScheme.onSurface, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
