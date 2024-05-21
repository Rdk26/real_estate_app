import 'package:flutter/material.dart';
import 'package:real_estate_app/theme/color.dart';

class CompanyItem extends StatelessWidget {
  const CompanyItem({
    super.key,
    required this.data,
    this.bgColor = Colors.white,
    this.color = AppColor.primary,
    this.selected = false,
    this.onTap,
  });

  final Map<String, dynamic> data;
  final Color bgColor;
  final Color color;
  final bool selected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.1),
              spreadRadius: .5,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(.3),
              ),
              child: Icon(data["icon"], color: color),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              data["name"],
              maxLines: 1,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                data["type"],
                style: const TextStyle(fontSize: 12, color: AppColor.darker),
              ),
            ),
            Visibility(
              visible: selected,
              child: Container(
                width: double.infinity,
                height: 2,
                decoration: const BoxDecoration(color: AppColor.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
