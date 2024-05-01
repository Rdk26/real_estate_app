import 'package:flutter/material.dart';
import 'package:real_estate_app/theme/color.dart';
import 'package:real_estate_app/utils/data.dart';
import 'package:real_estate_app/widgets/broker_item.dart';
import 'package:real_estate_app/widgets/company_item.dart';
import 'package:real_estate_app/widgets/custom_textbox.dart';
import 'package:real_estate_app/widgets/icon_box.dart';
import 'package:real_estate_app/widgets/recommend_item.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: AppColor.appBgColor,
          pinned: true,
          snap: true,
          floating: true,
          title: _buildHeader(),
        ),
        SliverToBoxAdapter(child: _buildBody())
      ],
    );
  }

  _buildHeader() {
    return const Row(
      children: [
        Expanded(
          child: CustomTextBox(
            hint: "Search",
            prefix: Icon(Icons.search, color: Colors.grey),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconBox(
          bgColor: AppColor.secondary,
          radius: 10,
          child: Icon(Icons.filter_list_rounded, color: Colors.white),
        )
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Matched Properties",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildRecommended(),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Companies",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildCompanies(),
          const SizedBox(
            height: 20,
          ),
          _buildBrokers(),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  _buildRecommended() {
    List<Widget> lists = List.generate(
      recommended.length,
      (index) => RecommendItem(
        data: recommended[index],
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  int _selectedCategory = 0;
  _buildCompanies() {
    List<Widget> lists = List.generate(
      companies.length,
      (index) => CompanyItem(
        data: companies[index],
        color: AppColor.listColors[index % 10],
        selected: index == _selectedCategory,
        onTap: () {
          setState(() {
            _selectedCategory = index;
          });
        },
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  _buildBrokers() {
    List<Widget> lists = List.generate(
      brokers.length,
      (index) => BrokerItem(
        data: brokers[index],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(children: lists),
    );
  }
}
