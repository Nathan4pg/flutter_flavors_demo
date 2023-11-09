import 'package:flutter/material.dart';
import 'package:flutter_code_practical/widgets/loading_skeleton.dart';

class CharacterImage extends StatelessWidget {
  final String imageUrl;
  final double imgWidth;
  final double defaultHeight; // Added default height parameter

  const CharacterImage({
    Key? key,
    required this.imageUrl,
    required this.imgWidth,
    this.defaultHeight = 400.0, // Default height set to 400
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: imgWidth,
          fit: BoxFit.cover, // Changed to BoxFit.cover to fill the height
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return LoadingSkeleton(items: [
              {
                'type': 'square',
                'width': 400,
                'height': defaultHeight,
                'margin': const [0, 0, 0, 0]
              }
            ]);
          },
          errorBuilder: (context, error, stackTrace) => Container(
            width: imgWidth,
            height: defaultHeight,
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromARGB(255, 66, 66, 66)
                : const Color.fromARGB(255, 226, 226, 226),
            child: const Center(
              child: Icon(
                Icons.error,
                size: 80,
                color: Color.fromARGB(70, 22, 22, 22),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
