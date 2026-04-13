import 'package:flutter/material.dart';
import 'package:flutter_book_reader/database/datebase_helper.dart';
import 'package:flutter_book_reader/models/book.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DataBaseHelper.instance.getAllBooks(),
        builder: (context, snapshot) =>
           snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              Docs bookData = snapshot.data![index];

              return ListTile(title: Text(bookData.title));
            },
          ) : Center(
            child: CircularProgressIndicator(),
          )
        ,
      ),
    );
  }
}
