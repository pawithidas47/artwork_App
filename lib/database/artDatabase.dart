import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../model/artItem.dart';

class ArtDatabase {
  String dbName;

  ArtDatabase({required this.dbName});

  // เปิดการเชื่อมต่อกับฐานข้อมูล
  Future<Database> openDatabase() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDir.path, dbName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  // เพิ่มผลงานใหม่ลงในฐานข้อมูล
  Future<int> insertArtwork(ArtItem item) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('artworks');
    
    // เพิ่มข้อมูลผลงานใหม่
    Future<int> keyID = store.add(db, {
      'title': item.title,
      'artist': item.artist,
      'year': item.year,
      'description': item.description,
      'dateAdded': item.dateAdded.toIso8601String(),
      'category': item.category,
      'number': item.number,
    });
    
    db.close();
    return keyID;
  }

  // โหลดข้อมูลทั้งหมดจากฐานข้อมูล
  Future<List<ArtItem>> loadAllArtworks() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('artworks');
    
    // ค้นหาผลงานทั้งหมดในฐานข้อมูลและจัดเรียงตามปี
    var snapshot = await store.find(db, finder: Finder(sortOrders: [SortOrder('year', false)]));
    
    List<ArtItem> artworks = snapshot.map((record) => ArtItem(
      keyID: record.key,
      title: record['title'].toString(),
      artist: record['artist'].toString(),
      year: int.parse(record['year'].toString()),
      description: record['description'].toString(),
      dateAdded: DateTime.parse(record['dateAdded'].toString()),
      category: record['category'].toString(),
      number: int.parse(record['number'].toString()),
    )).toList();
    
    db.close();
    return artworks;
  }

  // ลบผลงานออกจากฐานข้อมูล
  Future<void> deleteArtwork(ArtItem item) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('artworks');
    
    // ลบผลงานจากฐานข้อมูล
    await store.delete(db, finder: Finder(filter: Filter.equals(Field.key, item.keyID)));
    
    db.close();
  }

  // อัพเดตข้อมูลผลงานในฐานข้อมูล
  Future<void> updateArtwork(ArtItem item) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('artworks');
    
    // อัพเดตข้อมูลผลงานที่มี `keyID` ที่ตรงกัน
    await store.update(db, {
      'title': item.title,
      'artist': item.artist,
      'year': item.year,
      'description': item.description,
      'dateAdded': item.dateAdded.toIso8601String(),
      'category': item.category,
      'number': item.number,
    }, finder: Finder(filter: Filter.equals(Field.key, item.keyID)));
    
    db.close();
  }
}
