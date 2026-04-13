import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_reader/database/datebase_helper.dart';
import 'package:flutter_book_reader/models/book.dart';
import 'package:flutter_book_reader/network/network.dart';
import 'package:sqflite/sqflite.dart';

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
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Docs bookData = snapshot.data![index];
                  print("Author name -> ${bookData.author_key.toString()}");
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          bookData.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        trailing: Icon(Icons.delete),
                      
                        leading: Image.network(
                          
                          (bookData.cover_i != null && bookData.cover_i != 0)
                              ? "${Network.thumbNailBaseUrl}${bookData.cover_i}.jpg"
                              : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcGGf2dRY9hLwwz55FU4ltpJOkgU5ct58HdiibuKhW88Np-5Y5fTB_aEstTls00NmYLsZT6_7qQLy27sR0a2C7K80&s&ec=121630516",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        subtitle: Column(
                          children: [
                            Text(bookData.author_name.join(', ')),
                            ElevatedButton.icon(
                              icon: Icon(
                                Icons.favorite,
                                color: CupertinoColors.lightBackgroundGray,
                              ),
                              onPressed: () async {

                              


                              },
                              label: Text(
                                "Add to Favorite",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
