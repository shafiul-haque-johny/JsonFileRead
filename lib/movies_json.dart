import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:convert';

class JsonHome extends StatefulWidget {
  const JsonHome({Key? key}) : super(key: key);

  @override
  State<JsonHome> createState() => _JsonHomeState();
}

class _JsonHomeState extends State<JsonHome> {
  List _movies = [];

  // Fetch content from the json file
  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString('assets/movies.json');
    final data = await jsonDecode(response);
    setState(() {
      _movies = data["movies"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Shafiul Haque',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: readJsonFile,
              child: const Text('Load Json data'),
            ),
            // Display the data loaded from movies.json
            _movies.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: _movies.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              leading: Text(_movies[index]["id"]),
                              title: Text(_movies[index]["name"]),
                              subtitle: Text(_movies[index]["description"]),
                            ),
                          );
                        }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
