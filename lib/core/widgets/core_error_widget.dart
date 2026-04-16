import 'package:flutter/material.dart';

import '../theme/app_typogaphy.dart';

class CoreErrorWidget extends StatelessWidget {
  const CoreErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.warning_rounded,
                      color: Colors.redAccent, size: 80)),
              const SizedBox(height: 32),
              const Text('Ops! Conexão Perdida',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('Não conseguimos carregar os filmes.\nTente novamente.',
                  textAlign: TextAlign.center,
                  style:
                      AppTypography.titleLarge.copyWith(color: Colors.white70)),
            ])));
  }
}
