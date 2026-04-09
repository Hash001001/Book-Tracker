import 'package:flutter/material.dart';
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

              Row(children: [

              ElevatedButton(onPressed: (){}, child: Text("Save"),),

            

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
