import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/saved_pictures.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/image_model.dart';

class ImageScreen extends StatefulWidget {
  final ImageModel imageEntity;

  ImageScreen({required this.imageEntity});

  @override
  _ImageScreenState createState() =>
      _ImageScreenState(imageEntity: imageEntity);
}

class _ImageScreenState extends State<ImageScreen> {
  final ImageModel imageEntity;

  _ImageScreenState({required this.imageEntity});

  @override
  Widget build(BuildContext context) {
    CollectionReference history =
    FirebaseFirestore.instance.collection('pictures');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Full Size Image"),
        backgroundColor: Colors.black,
      ),
        body: GestureDetector(
          child: Center(
            child: Image.network(
              imageEntity.url + "&w=" + MediaQuery.of(context).size.width.toString(),
            ),
          ),
          onTap: () async {
            Navigator.pop(context);
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await history.add({
            'image': imageEntity.url + "&w=" + MediaQuery.of(context).size.width.toString(),
          }).then((value) => print('Pilt Lisatud'));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SavedPictures()),
          );
        },
        tooltip: 'Saved Pictures',
        child: const Icon(Icons.add_to_photos_sharp),
      ),
    );
  }
}