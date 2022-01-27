// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_dropzone_web_gl_issue/reactive_upload.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          ReactiveUpload(),
          ReactiveUpload(),
          ReactiveUpload(),
          ReactiveUpload(),
          ReactiveUpload(),
          ReactiveUpload(),
          ReactiveUpload(),
          ReactiveUpload(),
        ],
      ),
    );
  }
}

class DropzoneViewTest extends StatefulWidget {
  const DropzoneViewTest({Key? key}) : super(key: key);

  @override
  State<DropzoneViewTest> createState() => _DropzoneViewTestState();
}

class _DropzoneViewTestState extends State<DropzoneViewTest> {
  dynamic _previousFile;

  Future<void> _addFiles(List<File> newFiles) async {
    if (newFiles.isEmpty) {
      return;
    }

    /// Do whatever
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(
        64.0,
      ),
      child: DropzoneView(
        operation: DragOperation.copyMove,
        onDrop: (ev) async {
          if (ev != _previousFile) {
            if (ev is File) {
              await _addFiles([ev]);
            } else if (ev is List<File>) {
              await _addFiles(ev);
            }
            _previousFile = ev;
          }
        },
      ),
    );
  }
}
