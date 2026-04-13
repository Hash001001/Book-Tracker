import 'package:flutter/material.dart';
import 'package:flutter_book_reader/database/datebase_helper.dart';
import 'package:flutter_book_reader/network/network.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DataBaseHelper.instance.getAllFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error -> ${snapshot.error}");
            return Center(child: Text("Error ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var bookData = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: Image.network(
                        (bookData.cover_i != null && bookData.cover_i != 0)
                            ? "${Network.thumbNailBaseUrl}${bookData.cover_i}.jpg"
                            : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcGGf2dRY9hLwwz55FU4ltpJOkgU5ct58HdiibuKhW88Np-5Y5fTB_aEstTls00NmYLsZT6_7qQLy27sR0a2C7K80&s&ec=121630516",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      title: Text("Favorite book: ${bookData.title}", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      subtitle: Column(
                        children: [
                          Text(bookData.author_name.join(", "))
                        ],
                      ),
                      trailing: Icon(Icons.favorite, color: Colors.red,),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No Favorite book", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),));
          }
        },
      ),
    );
  }
}
