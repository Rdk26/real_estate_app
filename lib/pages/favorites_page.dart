import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/data.dart';
import 'package:real_estate_app/widgets/property_item.dart';
import 'package:real_estate_app/pages/property_details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Expanded(
              child: ListView.builder(
                itemCount: populars.length,
                itemBuilder: (context, index) {
                  final property = populars[index];
                  if (property["is_favorited"] == true) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PropertyDetailsPage(data: property),
                            ),
                          );
                        },
                        child: PropertyItem(
                          data: property,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink(); 
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
