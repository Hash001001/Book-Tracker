import 'dart:convert';

import 'package:flutter_book_reader/models/book.dart';
import 'package:http/http.dart' as http;

class Network {
  static const _baseUrl = "https://openlibrary.org/search.json";
  static const thumbNailBaseUrl = "https://covers.openlibrary.org/b/id/";

  Future<List<Docs>> searchBooks(String query) async {
    var url = Uri.parse("$_baseUrl?q=$query");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["docs"] != null && data["docs"] is List) {
          var docs = (data["docs"] as List? ??[])
              .map(
                (bookItem) => Docs.fromJson(bookItem as Map<String, dynamic>),
              )
              .toList();

          return docs;
        } else {
          return [];
        }
      } else {
        print("Error occurred while fetching data");
        return [];
      }
    } catch (e) {
      print("error fetching -> ${e}");
      return [];
    }
  }
}
