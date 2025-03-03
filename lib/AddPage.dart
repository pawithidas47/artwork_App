import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/artprovider.dart'; // นำเข้า ArtProvider

class AddPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();  // ตัวเลข
  final String _selectedCategory = 'Painting';  // หมวดหมู่

  final DateTime _selectedDate = DateTime.now(); // เลือกวันที่ตอนนี้

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Artwork')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _artistController,
              decoration: InputDecoration(
                labelText: 'Artist',
              ),
            ),
            TextField(
              controller: _yearController,
              decoration: InputDecoration(
                labelText: 'Year',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            TextField(
              controller: _numberController, // กรอกตัวเลข
              decoration: InputDecoration(
                labelText: 'Number',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            // ปุ่มเลือกวันที่
            TextButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != _selectedDate) {
                  // อัพเดทวันที่เลือก
                }
              },
              child: Text('Select Date'),
            ),
            // ปุ่มเพิ่มผลงาน
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _artistController.text.isNotEmpty &&
                    _yearController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  final title = _titleController.text;
                  final artist = _artistController.text;
                  final year = int.tryParse(_yearController.text) ?? 0;
                  final description = _descriptionController.text;
                  final number = int.tryParse(_numberController.text) ?? 0; // แปลง number เป็น int
                  final category = _selectedCategory;

                  // เพิ่มผลงานใหม่ไปยัง Provider
                  Provider.of<ArtProvider>(context, listen: false)
                      .addArtwork(
                    title,
                    artist,
                    year,
                    description,
                    number,        // ส่งตัวเลข
                    category,      // ส่งหมวดหมู่
                    _selectedDate, // ส่งวันที่ (DateTime) ไม่ใช้ millisecondsSinceEpoch
                  );

                  Navigator.pop(context); // กลับไปยังหน้า HomePage
                }
              },
              child: Text('Add Artwork'),
            ),
          ],
        ),
      ),
    );
  }
}
