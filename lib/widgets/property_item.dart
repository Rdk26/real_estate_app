import 'package:flutter/material.dart';
import 'package:real_estate_app/theme/color.dart';
import 'package:real_estate_app/pages/property_details_page.dart';
import 'custom_image.dart';
import 'icon_box.dart';

class PropertyItem extends StatelessWidget {
  const PropertyItem({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsPage(data: data),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 240,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.1),
              spreadRadius: .5,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            CustomImage(
              data["image"] ?? 'https://via.placeholder.com/150',
              width: double.infinity,
              height: 150,
              radius: 25,
            ),
            Positioned(
              right: 20,
              top: 130,
              child: _buildFavorite(),
            ),
            Positioned(
              left: 15,
              top: 160,
              child: _buildInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorite() {
    return IconBox(
      bgColor: AppColor.red,
      child: Icon(
        data["is_favorited"] != null && data["is_favorited"]
            ? Icons.favorite
            : Icons.favorite_border,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data["name"] ?? 'Sem título',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Icon(
              Icons.place_outlined,
              color: AppColor.darker,
              size: 13,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              data["location"] ?? 'Sem localização',
              style: const TextStyle(fontSize: 13, color: AppColor.darker),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          data["price"] ?? 'Sem preço',
          style: const TextStyle(
            fontSize: 15,
            color: AppColor.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
