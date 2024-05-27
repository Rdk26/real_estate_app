import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/models/user_model.dart';
import 'package:real_estate_app/pages/my_announcements_page.dart';
import 'package:real_estate_app/utils/data.dart';
import 'package:real_estate_app/widgets/icon_box.dart';
import 'package:real_estate_app/widgets/property_item.dart';
import 'package:real_estate_app/pages/property_details_page.dart';
import 'package:real_estate_app/theme/color.dart';
import 'package:real_estate_app/widgets/custom_textbox.dart';
import 'package:real_estate_app/widgets/category_item.dart';
import 'package:real_estate_app/widgets/recommend_item.dart';
import 'package:real_estate_app/widgets/recent_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> populars = [];

  @override
  void initState() {
    super.initState();
    fetchPopulars();
  }

  Future<void> fetchPopulars() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('properties').get();
      setState(() {
        populars = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error fetching popular properties: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showOptions(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
        FloatingActionButtonLocation.endFloat,
        const Offset(0, -50),
      ),
    );
  }

  _buildHeader() {
    final userModel = Provider.of<UserModel>(context);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Olá!",
                  style: TextStyle(
                    color: AppColor.darker,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  userModel.username,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/86506519?v=4',
                ),
                radius: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildBody() {
    List<Map<String, dynamic>> filteredPopulars = getFilteredProperties(
        _selectedCategory, populars.cast<Map<String, dynamic>>());
    List<Map<String, dynamic>> filteredRecommended = getFilteredProperties(
        _selectedCategory, recommended.cast<Map<String, dynamic>>());
    List<Map<String, dynamic>> filteredRecents = getFilteredProperties(
        _selectedCategory, recents.cast<Map<String, dynamic>>());

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          _buildSearch(),
          const SizedBox(
            height: 20,
          ),
          _buildCategories(),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Populares",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Ver tudo",
                  style: TextStyle(fontSize: 14, color: AppColor.darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildPopulars(filteredPopulars),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recomendado",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Ver tudo",
                  style: TextStyle(fontSize: 14, color: AppColor.darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildRecommended(filteredRecommended),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recente",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Ver tudo",
                  style: TextStyle(fontSize: 14, color: AppColor.darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildRecent(filteredRecents),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          const Expanded(
            child: CustomTextBox(
              hint: "Pesquisar",
              prefix: Icon(Icons.search, color: Colors.grey),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconBox(
            bgColor: AppColor.secondary,
            radius: 10,
            child: const Icon(Icons.filter_list_rounded, color: Colors.white),
            onTap: () {
              _showFilters(context);
            },
          ),
        ],
      ),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Filtros",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildFilterItem("Intervalo de Preço"),
              _buildFilterItem("Localização"),
              _buildFilterItem("Tipo"),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Aplicar filtros
                    Navigator.pop(context);
                  },
                  child: const Text("Aplicar Filtros"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Colocar anúncios"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/addAnnouncement');
                },
              ),
              ListTile(
                leading: const Icon(Icons.view_list),
                title: const Text("Visualizar meus anúncios"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAnnouncementsPage(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterItem(String label) {
    return ListTile(
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Processar clique no item de filtro
      },
    );
  }

  Widget _buildCategories() {
    List<Widget> lists = List.generate(
      categories.length,
      (index) => CategoryItem(
        data: categories[index],
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

  Widget _buildPopulars(List<Map<String, dynamic>> filteredPopulars) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300, // Adjusted height
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .8,
      ),
      items: List.generate(
        filteredPopulars.length,
        (index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PropertyDetailsPage(data: filteredPopulars[index]),
              ),
            );
          },
          child: PropertyItem(
            data: filteredPopulars[index],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommended(List<Map<String, dynamic>> filteredRecommended) {
    List<Widget> lists = List.generate(
      filteredRecommended.length,
      (index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PropertyDetailsPage(data: filteredRecommended[index]),
            ),
          );
        },
        child: RecommendItem(
          data: filteredRecommended[index],
        ),
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  Widget _buildRecent(List<Map<String, dynamic>> filteredRecents) {
    List<Widget> lists = List.generate(
      filteredRecents.length,
      (index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PropertyDetailsPage(data: filteredRecents[index]),
            ),
          );
        },
        child: RecentItem(
          data: filteredRecents[index],
        ),
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  List<Map<String, dynamic>> getFilteredProperties(
      int categoryIndex, List<Map<String, dynamic>> properties) {
    if (categoryIndex == 0) {
      return properties;
    } else {
      String category = categories[categoryIndex]['name'];
      return properties
          .where((property) => property['category'] == category)
          .toList();
    }
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final FloatingActionButtonLocation location;
  final Offset offset;

  CustomFloatingActionButtonLocation(this.location, this.offset);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final Offset baseOffset = location.getOffset(scaffoldGeometry);
    return baseOffset + offset;
  }
}
