import 'dart:convert';

import 'package:final_project/models/image_model.dart';
import 'package:http/http.dart' as http;

class PhotosRetriever {
  static Future<List<dynamic>> _getPhotos(int page) async {
      final response = await http.get(Uri.http( 'api.unsplash.com', '/photos',  {
      'client_id': '4XcMxy0866AAYbQusooKEBl_I-UkQYEYc5mbq3qP6uw', //unsplash API account access key user r4zmuz
      'page': page.toString(),
    }));


    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load list');
    }
  }

  static Future<List<ImageModel>> getImagesList(int page) async {
    List<dynamic> jsonList = await PhotosRetriever._getPhotos(page);
    List<ImageModel> images = [];

    for (int i = 0; i < jsonList.length; ++i) {
      images.add(new ImageModel.fromJSON(jsonList[i]));
    }

    return images;
  }
}

