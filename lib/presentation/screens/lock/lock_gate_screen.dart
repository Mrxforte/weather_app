import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/settings_provider.dart';

// Full-screen lock gate shown on app launch when pattern is enabled
class LockGateScreen extends StatefulWidget {
  const LockGateScreen({super.key});

  @override
  State<LockGateScreen> createState() => _LockGateScreenState();
}

class _LockGateScreenState extends State<LockGateScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showLock());
  }

  void _showLock() {
    final settings = context.read<SettingsProvider>();
    if (!settings.isPatternLockEnabled) {
      context.go(AppRoutes.home);
      return;
    }
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
        context.go(AppRoutes.home);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
}
