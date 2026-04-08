import 'package:flutter/material.dart';
import 'package:flutter_book_reader/models/book.dart';
import 'package:flutter_book_reader/network/network.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Network network = Network();
  List<Docs> _booksList = [];
  bool _isLoading = false;
  Future<void> serachBooks(String query) async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<Docs> books = await network.searchBooks(query);
      setState(() {
        _isLoading = false;
        _booksList = books;
      });
    } catch (e) {
      _isLoading = false;
      print("Error occurred while searching books: $e");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text("Search book here"),
                    suffixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: (value) {
                    serachBooks(value);
                  },
                ),
              ),

              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: _booksList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    Docs bookData = _booksList[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              "${Network.thumbNailBaseUrl}${bookData.cover_i}.jpg",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /* Expanded(
                child: _isLoading ? Center(
                  child: CircularProgressIndicator(),
                ): ListView.builder(
                  itemCount: _booksList.length,
                  itemBuilder: (context, index) {
                    Docs bookData = _booksList[index];
                    return Card(
                      child: ListTile(
                        title: Text(bookData.title),
                        subtitle: Text(bookData.author_name.join(', & ')),
                      ),
                    );
                  },
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
