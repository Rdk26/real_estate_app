import 'package:flutter/material.dart';
import 'package:real_estate_app/theme/color.dart';

class PropertyItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const PropertyItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              data['image'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 5),
                Text(
                  '${data['price']} MT',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        data['location'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      data['is_favorited']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 16,
                      color: data['is_favorited'] ? Colors.red : Colors.grey,
                    ),
                    const Spacer(),
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const Icon(Icons.star_border,
                        size: 16, color: Colors.amber),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
