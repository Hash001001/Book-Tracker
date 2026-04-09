import 'package:flutter/material.dart';
import 'package:flutter_book_reader/models/book.dart';
import 'package:flutter_book_reader/network/network.dart';
import 'package:flutter_book_reader/providers/home_provider.dart';
import 'package:flutter_book_reader/screens/book_details.dart';
import 'package:flutter_book_reader/utils/book_details_arguments.dart';
import 'package:flutter_book_reader/widgets/image_view.dart';
import 'package:flutter_book_reader/widgets/shimmer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeScreenProvider>();

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
                    context.read<HomeScreenProvider>().serachBooks(value);
                  },
                ),
              ),

              SizedBox(height: 20),
              Expanded(
                child: homeProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        itemCount: homeProvider.booksList.length,
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.58,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),

                        // 🚀 PERFORMANCE BOOST
                        cacheExtent: 1000,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: true,

                        itemBuilder: (context, index) {
                          Docs bookData = homeProvider.booksList[index];

                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/details',
                                  arguments: BookDetailArguments(
                                    bookData: bookData,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),

                                  // 🎨 Play Store shadow
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// 📘 BOOK COVER
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: ImageView(bookData: bookData),
                                    ),

                                    /// 📄 BOOK INFO
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bookData.title ?? "No Title",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          Text(
                                            (bookData.author_name != null &&
                                                    bookData
                                                        .author_name!
                                                        .isNotEmpty)
                                                ? bookData.author_name![0]
                                                : "Unknown Author",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
