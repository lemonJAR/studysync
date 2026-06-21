import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/theme.dart';
import 'config/constants.dart';
import 'config/spacing.dart';
import 'providers/providers.dart';
import 'widgets/common/custom_button.dart';
import 'widgets/common/custom_card.dart';

class StudySyncApp extends ConsumerWidget {
  const StudySyncApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const _DesignSystemShowcase(),
    );
  }
}

/// Showcase of all design system components
class _DesignSystemShowcase extends ConsumerWidget {
  const _DesignSystemShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeModeProvider.notifier).state = !isDarkMode;
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.paddingMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Buttons Section
            Text(
              'Buttons',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            AppSpacing.gapVerticalMd,
            PrimaryButton(
              label: 'Primary Button',
              onPressed: () {},
            ),
            AppSpacing.gapVerticalMd,
            SecondaryButton(
              label: 'Secondary Button',
              onPressed: () {},
            ),
            AppSpacing.gapVerticalMd,
            TextButtonWidget(
              label: 'Text Button',
              onPressed: () {},
            ),
            AppSpacing.gapVerticalLg,

            // Cards Section
            Text(
              'Cards',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            AppSpacing.gapVerticalMd,
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Custom Card',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppSpacing.gapVerticalSm,
                  Text(
                    'This is a reusable card widget with padding and shadow.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            AppSpacing.gapVerticalMd,
            StatsCard(
              title: 'Total Tasks',
              value: '12',
              icon: Icons.task_alt,
            ),
            AppSpacing.gapVerticalLg,

            // Theme Info
            Text(
              'Current Theme',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            AppSpacing.gapVerticalMd,
            CustomCard(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isDarkMode ? '🌙 Dark Mode' : '☀️ Light Mode',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppSpacing.gapVerticalSm,
                  Text(
                    'Tap the theme icon in the app bar to toggle between light and dark themes.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            AppSpacing.gapVerticalLg,

            // Status Info
            CustomCard(
              backgroundColor: Colors.green.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      AppSpacing.gapHorizontalMd,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Day 3: Setup Complete! ✅',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            AppSpacing.gapVerticalSm,
                            Text(
                              'All design system components created and ready for use.',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.gapVerticalXl,
          ],
        ),
      ),
    );
  }
}