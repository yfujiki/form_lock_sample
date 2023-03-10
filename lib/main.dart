import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_lock_sample/providers.dart';

import 'models.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Item Locking Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Form Item Locking Demo'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageForm = ref.watch(imageFormStateProvider);
    final form = ref.watch(lockedFormStateProvider);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: [
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: form.items.map(
                (e) {
                  if (e.locked) {
                    return ListTile(
                      title: Text(e.title),
                      trailing: const Icon(Icons.lock),
                    );
                  } else {
                    return ListTile(
                      title: Text(e.title),
                    );
                  }
                },
              ).toList(),
            ),
            const SizedBox(),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: imageForm.items.map((e) {
                return ListTile(
                  title: Text(e.title),
                  trailing: MaterialButton(
                    child: const Icon(Icons.upload),
                    onPressed: () {
                      _uploadImageFor(e, ref);
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _uploadImageFor(ImageFormItem item, WidgetRef ref) {
    final imageForm = ref.read(imageFormStateProvider.notifier);
    imageForm.loadImageForItemId(item.id, File("path_to_image"));
  }
}
