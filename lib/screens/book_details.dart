import 'package:flutter/material.dart';
import 'package:flutter_book_reader/database/datebase_helper.dart';
import 'package:flutter_book_reader/models/book.dart';
import 'package:flutter_book_reader/utils/book_details_arguments.dart';
import 'package:flutter_book_reader/widgets/image_view.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  //final Docs bookData;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailArguments;
    final Docs bookData = args.bookData;

    return Scaffold(
      appBar: AppBar(
        title: Text(bookData.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 200,
                  height: 300,
                  child: ImageView(bookData: bookData),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  bookData.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                  maxLines: 2,
                ),
              ),
              if (bookData.author_name.isNotEmpty)
                Text(
                  bookData.author_name[0],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),

              Text(
                "Published on: ${bookData.first_publish_year}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              Text(
                "Edition count: ${bookData.edition_count}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              if (bookData.language.isNotEmpty)
                Text(
                  "Language: ${bookData.language[0]}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        int savedbook = await DataBaseHelper.instance.inserBook(
                          bookData,
                        );

                        SnackBar snackBar = SnackBar(
                          content: Text(
                            savedbook > 0
                                ? "Book saved successfully: $savedbook"
                                : "Failed to save book",
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } catch (e) {
                        print("Error while saving $e");
                      }
                    },
                    child: Text("Save"),
                  ),

                  ElevatedButton.icon(
                    onPressed: () async {
                      await DataBaseHelper.instance
                          .markBookAsFavorite(
                            bookData.key,
                            !bookData.is_favorite,
                          )
                          .then((onValue){
                            setState(() {
                              bookData.is_favorite = !bookData.is_favorite;
                            });
                          });
                    },
                    icon: Icon( bookData.is_favorite ?  Icons.favorite : Icons.favorite_border_outlined),
                    label: Text("Favorite"),
                  ),
                ],
              ),

              SizedBox(height: 15),

              Text(
                "Description",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 5),

              bookData.ia_collection.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: BoxBorder.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                      child: bookData.ia_collection.isNotEmpty
                          ? Text(bookData.ia_collection.join(', '))
                          : Text(""),
                    )
                  : Center(child: Text("No description available")),
            ],
          ),
        ),
      ),
    );
  }
}
