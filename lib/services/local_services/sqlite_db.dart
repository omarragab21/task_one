// ignore_for_file: prefer_const_declarations, unused_local_variable

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_one/app/questions_cycle/widgets/question_item.dart';

import '../../app/questions_cycle/models/questions_item_model.dart';

final String tableQuestion = 'question';
final String columnId = 'id';
final String columnQuestionLink = 'linkquestion';
final String columnProfileImage = 'profileimage';
final String columnDisplayName = 'displayname';
final String columnTitle = 'title';
final String columnCerditDate = 'creditdate';
final String columnAnswerd = 'answerd';
final String columnCountAnswerd = 'countanswerd';
final String tableTag = 'tag';
final String tableQuestionId = 'questionid';
final String tableTagName = 'tagname';

class LocalDataBase {
  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('task_one.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
create table $tableQuestion ( 
  $columnId integer primary key autoincrement, 
  $columnDisplayName text not null,
  $columnProfileImage text not null,
  $columnAnswerd integer not null,
  $columnCerditDate num not null,
  $columnTitle text not null,
  $columnCountAnswerd integer not null,
  $columnQuestionLink text not null,
  $tableQuestionId text not null
  )
''');

    await db.execute(''' 
    create table tags (
     tag_id integer primary key autoincrement,
     $tableTagName text not null,
     $tableQuestionId integer not null
    )
    ''');
  }

  Future<void> insertDb(
      String displayName,
      String profileImage,
      bool isAnswerd,
      int countAnswerd,
      int cerditDate,
      String questionLink,
      String title,
      String questionId,
      List<String> tags) async {
    var map = {
      columnDisplayName: displayName,
      columnProfileImage: profileImage,
      columnAnswerd: isAnswerd ? 1 : 0,
      columnCerditDate: cerditDate,
      columnCountAnswerd: countAnswerd,
      columnQuestionLink: questionLink,
      columnTitle: title,
      tableQuestionId: questionId
    };

    try {
      final db = await database;
      db.transaction((txn) {
        return txn.insert(tableQuestion, map, conflictAlgorithm: ConflictAlgorithm.replace);
      });
      for (var tag in tags) {
        var tagMap = {tableTagName: tag, tableQuestionId: questionId};
        db.transaction((txn) {
          return txn.insert('tags', tagMap, conflictAlgorithm: ConflictAlgorithm.replace);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<QuestionItemModel>> getData() async {
    print('Omar');
    List<QuestionItemModel> questions = [];
    final db = await database;
    var maps = await db.query(tableQuestion);
    for (var question in maps) {
      QuestionItemModel questionItem = QuestionItemModel();
      questionItem = QuestionItemModel.fromJson(question);
      questions.add(questionItem);
    }
    print(questions.length);

    return questions;
  }

  Future<List<String>> tags(String questionId) async {
    List<String> tags = [];
    final db = await database;
    var maps = await db.query('tags', where: '$tableQuestionId = ?', whereArgs: [questionId]);
    for (var tag in maps) {
      tags.add(tag[tableTagName].toString());
    }
    print(tags.length);
    return tags;
  }
}
