import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:digital_health_module/main.dart' as digital_health_module;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await digital_health_module.initializeModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Health Wrapper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Digital Health Wrapper'),
    );
  }
}

void addStudy(String? id) {
  debugPrint('Study selected: $id');
  digital_health_module.addStudy(id!);
}

void startStudy() {
  debugPrint('Asking DHM to start study');
  digital_health_module.startStudy();
}

void stopStudy() {
  debugPrint('Asking DHM to stop study');
  digital_health_module.stopStudy();
}

void disposeStudy() {
  debugPrint('Asking DHM to dispose study');
  digital_health_module.disposeStudy();
}

enum IconLabel {
  sleep('Sleep', Icons.bedtime),
  steps('Steps', Icons.directions_walk);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController iconController = TextEditingController();
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 24),
            DropdownMenu<IconLabel>(
              controller: iconController,
              enableFilter: true,
              requestFocusOnTap: true,
              leadingIcon: const Icon(Icons.search),
              label: const Text('Study'),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              ),
              onSelected: (IconLabel? icon) {
                setState(() {
                  selectedIcon = icon;
                });
              },
              dropdownMenuEntries:
                  IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
                (IconLabel icon) {
                  return DropdownMenuEntry<IconLabel>(
                    value: icon,
                    label: icon.label,
                    leadingIcon: Icon(icon.icon),
                  );
                },
              ).toList(),
            ),
            if (selectedIcon != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(height: 30),
                  CupertinoButton.filled(
                      onPressed: () {
                        addStudy(selectedIcon?.label);
                      },
                      child: const Text('Set Study')),
                  const SizedBox(height: 30),
                  CupertinoButton.filled(
                      onPressed: () {
                        startStudy();
                      },
                      child: const Text('Start Study')),
                  const SizedBox(height: 30),
                  CupertinoButton.filled(
                      onPressed: () {
                        stopStudy();
                      },
                      child: const Text('Stop Study')),
                  const SizedBox(height: 30),
                  CupertinoButton.filled(
                      onPressed: () {
                        disposeStudy();
                      },
                      child: const Text('Dispose Study')),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
