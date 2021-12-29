import 'package:final_project/screens/saved_pictures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_project/models/image_model.dart';
import 'package:final_project/services/image_api.dart';
import 'package:final_project/screens/imagepage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ImageModel> images = [];

  int _page = 1;
  bool _loading = true;

  void _loadImages() {
    _loading = true;
    PhotosRetriever.getImagesList(_page++).then((value) {
      setState(() {
        _loading = false;
        images.addAll(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    _loadImages();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
                " Scrollable Endless Gallery App",
                style: TextStyle(fontSize: 20),
              )),
          backgroundColor: Colors.black,
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SavedPictures()),
          );
        },
        tooltip: 'Saved Pictures',
        child: const Icon(Icons.wb_cloudy),
      ),
        body: ListView.builder(
                itemCount: images.length + 1,
                itemBuilder: (context, index) {
                  if (index >= images.length) {
                    if (!_loading) {
                      _loadImages();
                    }
                    return Center(child: CircularProgressIndicator());
                  }
                  return _buildRow(images[index]);
                },
               ),


    );
  }

  Widget _buildRow(ImageModel image) {

    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Padding(
                  child: GestureDetector(
                      child: Image.network(image.thumb),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ImageScreen(imageEntity: image);
                        }));
                      }),
                  padding: EdgeInsets.all(4.0))),
          Expanded(
              flex: 3,
              child: Padding(
                  child: Column(
                    children: [
                      Padding(
                          child: Text(
                            'Picture by:',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 4.0)),
                      Padding(
                          child: Text(
                            "\u00a9" + image.author,
                            style: TextStyle(fontSize: 14),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 4.0))
                    ],
                  ),
                  padding: EdgeInsets.all(4.0)))
        ],
      ),
    );
  }
}