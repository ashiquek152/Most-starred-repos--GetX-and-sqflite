import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:thiran_task2/app/modules/home/gitmodel_model.dart';



enum DbTypes { thirtyDays, ninetyDays }



class SQLDB {
  
  late Database _databasethirtyDays;
  late Database _databaseNinetyDays;



  //?**************************Initialize SQFlite DB********************************/

  Future<void> iniTializeDB() async {
    _databasethirtyDays = await openDatabase(
      "thirtyDays.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE thirtyDaysData (id INTEGER PRIMARY KEY, repoName TEXT, repoDescription TEXT, avatarUrl TEXT, starsCount TEXT, ownerName TEXT)');
      },
    );
    log("Thirty Days Data DB INITIALIZED");

    _databaseNinetyDays = await openDatabase(
      "ninetyDays.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE ninetyDaysData (id INTEGER PRIMARY KEY, repoName TEXT, repoDescription TEXT, avatarUrl TEXT, starsCount TEXT, ownerName TEXT)');
      },
    );
    log("Ninety Days Data DB INITIALIZED");
  }
  //?**********************************************************/


  //?****************** Add new data to Local DB****************************************/

  Future<void> writeToLocalDB(
      {required Items items, required DbTypes dbTypes}) async {
    try {
      if (dbTypes == DbTypes.thirtyDays) {
        await _databasethirtyDays.rawInsert(
            'INSERT INTO thirtyDaysData(repoName, repoDescription, avatarUrl, starsCount, ownerName) VALUES(?,?,?,?,?)',
            [
              items.name ?? "Not available",
              items.description ?? "Not available",
              items.owner!.avatarUrl ?? "Not available",
              items.stargazersCount ?? "Not avilable",
              items.owner!.login ?? "Not available",
            ]);
      }
      await _databaseNinetyDays.rawInsert(
          'INSERT INTO ninetyDaysData(repoName, repoDescription, avatarUrl, starsCount, ownerName) VALUES(?,?,?,?,?)',
          [
            items.name ?? "Not available",
            items.description ?? "Not available",
            items.owner!.avatarUrl ?? "Not available",
            items.stargazersCount ?? "Not avilable",
            items.owner!.login ?? "Not available",
          ]);
      // readFromDB();
    } catch (e) {
      log(e.toString());
    }
  }
  //?**********************************************************/



//?*********Check for existing data in Local DB******************/
  Future<bool> checkExistingInDB({required String repoName, required DbTypes dbTypes}) async {
    if (dbTypes == DbTypes.thirtyDays) {
      final data = await _databasethirtyDays
          .rawQuery('SELECT * FROM thirtyDaysData WHERE repoName="$repoName"');
      return data.isNotEmpty ? true : false;
    }
    final data = await _databaseNinetyDays
        .rawQuery('SELECT * FROM ninetyDaysData WHERE repoName="$repoName"');
    return data.isNotEmpty ? true : false;
  }

  Future<void> readFromDB({required DbTypes dbTypes}) async {
   if (dbTypes==DbTypes.thirtyDays) {
      final data =
        await _databasethirtyDays.rawQuery('SELECT * FROM thirtyDaysData');
    log(data.toString());
   } final data =
        await _databaseNinetyDays.rawQuery('SELECT * FROM ninetyDaysData');
    log(data.toString());
  }
  //?**********************************************************/

  // Future<void> deleteLocalDB() async {
  //   _database.delete("thirtyDaysData");
  //   readFromDB();
  // }
}

