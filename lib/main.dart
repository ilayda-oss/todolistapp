import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _tasks = []; // Görevlerin saklandığı liste

  void _addTask(String task) {
    setState(() {
      _tasks.add(task); // Yeni görevi listeye ekle
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index); // Görevi listeden sil
    });
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = ''; // Yeni görev adı

        return AlertDialog(
          title: const Text('Yeni Görev'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Görev adını girin',
            ),
            onChanged: (value) {
              newTask = value; // Kullanıcı yeni görevi buraya girer
            },
            onSubmitted: (value) {
              _addTask(value);
              Navigator.of(context).pop(); // Dialog'u kapat
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                if (newTask.isNotEmpty) {
                  _addTask(newTask);
                  Navigator.of(context).pop(); // Dialog'u kapat
                }
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteTaskDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Görevi Sil."),
            content: const Text("Görevi silmek istediğine emin misiniz?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("İptal")),
              TextButton(
                  onPressed: () {
                    _removeTask(index);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Sil")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 224, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 184, 237),
        title: const Text("ToDo List App"),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_tasks[index]),
            onTap: () => _showDeleteTaskDialog(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
