import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CharacterImage extends StatelessWidget {
  final String imageUrl;
  final double imgWidth;

  const CharacterImage({
    Key? key,
    required this.imageUrl,
    required this.imgWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: imgWidth,
      fit: BoxFit.contain,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Shimmer.fromColors(
          baseColor: const Color.fromARGB(118, 123, 123, 123),
          highlightColor: const Color.fromARGB(130, 149, 149, 149),
          child: Container(
            width: imgWidth, // Use the passed-in width
            height:
                imgWidth, // Keeping the height equal to the width as it seems you're working with squared space
            color: Colors.white,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => SizedBox(
        width: imgWidth,
        height: imgWidth,
        child: Center(
          child: Image.asset('assets/images/no-image.jpeg',
              width: double
                  .infinity), // Ensure 'no-image.jpeg' exists in the assets
        ),
      ),
    );
  }
}
