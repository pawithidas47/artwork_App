class ArtItem {
  int? keyID;
  String title;
  String artist;
  int year;
  String description;
  int number; // อายุ/คะแนน
  String category; // หมวดหมู่
  DateTime dateAdded; // วันที่เพิ่มข้อมูล

  ArtItem({
    this.keyID,
    required this.title,
    required this.artist,
    required this.year,
    required this.description,
    required this.number,
    required this.category,
    required this.dateAdded,
  });
}
