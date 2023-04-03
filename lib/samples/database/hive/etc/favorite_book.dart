import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/hive_config.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

const List<String> books = [
  'Harry Potter',
  'To Kill a Mockingbird',
  'The Hunger Games',
  'The Giver',
  'Brave New World',
  'Unwind',
  'World War Z',
  'The Lord of the Rings',
  'The Hobbit',
  'The Adventures of Huckleberry Finn',
];

class FavoriteBook extends StatefulWidget {
  const FavoriteBook({Key? key}) : super(key: key);

  @override
  State<FavoriteBook> createState() => _FavoriteBookState();
}

class _FavoriteBookState extends State<FavoriteBook> {
  final Box<String> _fbBox = Hive.box<String>(HiveCfg.tableFavoriteName);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Favorite Books'),
      actions: [
        IconButton(
          onPressed: _backup,
          icon: const Icon(Icons.backup),
        ),
        IconButton(
          onPressed: _restore,
          icon: const Icon(Icons.restore),
        )
      ],
    ),
    body: ValueListenableBuilder(
      valueListenable: _fbBox.listenable(),
      builder: (context, fbBox, _) => ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, bIndex) => ListTile(
          title: Text(books[bIndex]),
          trailing: IconButton(
            icon: (
                _fbBox.containsKey(bIndex)
                  ? const Icon(Icons.favorite, color: Colors.deepOrange,)
                  : const Icon(Icons.favorite_border)
            ),
            onPressed: () => _fbBox.containsKey(bIndex)
                ? _fbBox.delete(bIndex)
                : _fbBox.put(bIndex, books[bIndex]),
          ),
        ),
      ),
    ),
  );
  
  Future<void> _backup() async {
    if (_fbBox.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('좋아하는 책을 고르세요')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('백업을 시작합니다.')),
      );

      /// 하이브에 저장된 모든 데이터를 맵 형식으로 변환함.
      Map<String, String> fbMap = _fbBox.toMap()
          .map((key, value) => MapEntry(key.toString(), value));
      String fbJson = jsonEncode(fbMap);
      Directory dir = await _getDirectory();
      debugPrint('New Dir: ${dir.absolute}');
      String fullPath = '${dir.path}'
        '${HiveCfg.dirFormat.format(DateTime.now())}.hivebackup';
      debugPrint('New backupfile: $fullPath');
      File backupFile = File(fullPath);
      await backupFile.writeAsString(fbJson);
    }
  }

  Future<Directory> _getDirectory() async {
    Directory? dir = await getExternalStorageDirectory();
    const String pathExt = '/backups/';
    Directory newDir = Directory('${dir!.path}$pathExt');
    if (await newDir.exists() == false) {
      newDir.create(recursive: true);
    }
    return newDir;
  }

  Future<void> _restore() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('백업데이터 복구.')),
    );

    FilePickerResult? fpResult =
        await FilePicker.platform.pickFiles(type: FileType.any);
    debugPrint('File Picker Result: $fpResult');
    if (fpResult == null) return;

    File file = File(fpResult.files.single.path!);
    _fbBox.clear();
    Map<dynamic, dynamic> map =
        /* file.readAsStringSync() */
        jsonDecode(await file.readAsString()) as Map<dynamic, dynamic>;
    Map<int, String> newMap =
        map.map<int, String>((key, value) => MapEntry(int.parse(key), value));
    _fbBox.putAll(newMap);
  }

}
