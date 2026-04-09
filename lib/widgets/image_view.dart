import 'package:flutter/material.dart';
import 'package:flutter_book_reader/models/book.dart';
import 'package:flutter_book_reader/network/network.dart';
import 'package:flutter_book_reader/widgets/shimmer.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
    required this.bookData,
  });

  final Docs bookData;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      bookData.cover_i != null
          ? "${Network.thumbNailBaseUrl}${bookData.cover_i}.jpg"
          : "https://via.placeholder.com/150",
    
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
    
      // 🚀 PERFORMANCE
      cacheWidth: 300,
    
      /// ✨ FADE IN
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
    
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      },
    
      /// 🔥 SHIMMER LOADER
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
    
        return ShimmerEffect();
      },
    
      /// ❌ ERROR UI
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 200,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.broken_image, size: 40),
          ),
        );
      },
    );
  }
}