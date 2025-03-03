import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/artprovider.dart'; // นำเข้า ArtProvider
import 'AddPage.dart'; // หน้าสำหรับการเพิ่มข้อมูลใหม่
import 'model/artItem.dart'; // นำเข้า ArtItem

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ArtProvider(),
      child: ArtworkApp(),
    ),
  );
}

class ArtworkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artwork App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Artwork')),
      body: Consumer<ArtProvider>(
        builder: (context, artProvider, child) {
          return ListView.builder(
            itemCount: artProvider.artworks.length,
            itemBuilder: (context, index) {
              final artwork = artProvider.artworks[index];
              return ListTile(
                title: Text(artwork.title),
                subtitle: Text(artwork.artist),
                onTap: () {
                  // แสดงรายละเอียดของผลงาน
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
