import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';


class SavedPictures extends StatefulWidget{

  const SavedPictures({Key? key}) : super(key: key);

    @override
    State createState() => SavedPicturesState(
      );
    }

class SavedPicturesState extends State<SavedPictures>{
  final Stream<QuerySnapshot> history =
  FirebaseFirestore.instance.collection('pictures').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Scroll Saved Pictures"),
        backgroundColor: Colors.black,
      ),

      body:
      Container(
        height: 500,
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: StreamBuilder<QuerySnapshot>(
          stream: history,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong.');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }

            final data = snapshot.requireData;


            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return Image.network(
                  data.docs[index]['image'],
                  cacheHeight: 600,
                  cacheWidth: 400,
                );
              },
            );
          },
        ),
      ),
    );
  }
}