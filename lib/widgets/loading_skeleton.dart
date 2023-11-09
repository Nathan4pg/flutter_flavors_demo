import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem {
  final String type;
  final dynamic
      width; // dynamic because width can be a double or a string ('100%').
  final double height;
  final EdgeInsetsGeometry margin;

  ShimmerItem({
    required this.type,
    required this.width,
    required this.height,
    required this.margin,
  });

  factory ShimmerItem.fromMap(Map<String, dynamic> map) {
    return ShimmerItem(
      type: map['type'],
      width: map['width'] is String && map['width'] == '100%'
          ? double.infinity
          : double.parse(map['width'].toString()),
      height: map['height'].toDouble(),
      margin: EdgeInsets.fromLTRB(
        map['margin'][0].toDouble(),
        map['margin'][1].toDouble(),
        map['margin'][2].toDouble(),
        map['margin'][3].toDouble(),
      ),
    );
  }
}

class LoadingSkeleton extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const LoadingSkeleton({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((itemMap) {
        final shimmerItem = ShimmerItem.fromMap(itemMap);
        return Container(
          margin: shimmerItem.margin,
          child: SizedBox(
            width: shimmerItem.type == 'circle'
                ? shimmerItem.height
                : shimmerItem.width,
            height: shimmerItem.height,
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 66, 66, 66)
                  : const Color.fromARGB(255, 226, 226, 226),
              highlightColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 100, 100, 100)
                  : const Color.fromARGB(255, 242, 242, 242),
              child: Container(
                decoration: BoxDecoration(
                  // borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Colors.grey,
                  shape: shimmerItem.type == 'circle'
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
