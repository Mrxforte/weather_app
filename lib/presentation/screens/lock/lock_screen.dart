import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/settings_provider.dart';

// Shows pattern lock if enabled, then navigates to child
class LockScreen extends StatefulWidget {
  final Widget child;

  const LockScreen({super.key, required this.child});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool _unlocked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLock();
    });
  }

  void _checkLock() {
    final settings = context.read<SettingsProvider>();
    if (settings.isPatternLockEnabled) {
      _showLockScreen();
    } else {
      setState(() => _unlocked = true);
    }
  }

  void _showLockScreen() {
    final settings = context.read<SettingsProvider>();
    final l10n = S.of(context)!;
    screenLock(
      context: context,
      correctString: settings.patternLock!,
      canCancel: false,
      title: Text(
        l10n.unlockApp,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      config: const ScreenLockConfig(backgroundColor: Color(0xFF1A1A2E)),
      secretsConfig: const SecretsConfig(
        spacing: 12,
        secretConfig: SecretConfig(
          borderColor: Colors.white38,
          enabledColor: Colors.white,
        ),
      ),
      keyPadConfig: KeyPadConfig(
        buttonConfig: KeyPadButtonConfig(
          foregroundColor: Colors.white,
          fontSize: 24,
        ),
      ),
      onUnlocked: () {
        Navigator.pop(context);
        setState(() => _unlocked = true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_unlocked) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.nightGradient,
            ),
          ),
        ),
      );
    }
    return widget.child;
  }
}

// Helper to set up a new pattern lock from settings
void showSetPatternDialog(BuildContext context) {
  final l10n = S.of(context)!;
  screenLockCreate(
    context: context,
    title: Text(
      l10n.setPattern,
      style: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    confirmTitle: Text(
      l10n.confirmPattern,
      style: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    config: const ScreenLockConfig(backgroundColor: Color(0xFF1A1A2E)),
    secretsConfig: const SecretsConfig(
      spacing: 12,
      secretConfig: SecretConfig(
        borderColor: Colors.white38,
        enabledColor: Colors.white,
      ),
    ),
    keyPadConfig: KeyPadConfig(
      buttonConfig: KeyPadButtonConfig(
        foregroundColor: Colors.white,
        fontSize: 24,
      ),
    ),
    onConfirmed: (value) {
      context.read<SettingsProvider>().setPatternLock(value);
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.patternSaved)));
    },
    onError: (retries) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.patternMismatch)));
    },
  );
}
