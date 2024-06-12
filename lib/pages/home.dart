import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:real_estate_app/pages/property_details_page.dart';
import 'package:real_estate_app/theme/color.dart';
import 'package:real_estate_app/utils/data.dart';
import 'package:real_estate_app/widgets/property_item.dart';
import 'package:real_estate_app/widgets/recommend_item.dart';
import 'package:real_estate_app/widgets/recent_item.dart';
import 'package:real_estate_app/widgets/custom_textbox.dart';
import 'package:real_estate_app/widgets/icon_box.dart';
import 'package:real_estate_app/widgets/category_item.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class HomePage extends StatefulWidget {
  final String userName;

  const HomePage({super.key, required this.userName});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> firebasePopulars = [];
  int _selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    fetchPopularsFromFirebase();
  }

  Future<void> fetchPopularsFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('properties').get();
      setState(() {
        firebasePopulars = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'image': data['image'] ?? 'https://via.placeholder.com/150',
            'name': data['title'] ?? 'Sem título',
            'price': data['price'] ?? 'Sem preço',
            'location': data['location'] ?? 'Sem localização',
            'is_favorited': data['is_favorited'] ?? false,
            'category': data['category'] ?? 'Uncategorized',
          };
        }).toList();
      });
    } catch (e) {
      logger.e("Error fetching popular properties: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPopulars = getFilteredProperties(_selectedCategory, firebasePopulars);
    List<Map<String, dynamic>> filteredRecommended = getFilteredProperties(_selectedCategory, recommended.cast<Map<String, dynamic>>());
    List<Map<String, dynamic>> filteredRecents = getFilteredProperties(_selectedCategory, recents.cast<Map<String, dynamic>>());

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
          SliverToBoxAdapter(child: _buildBody(filteredPopulars, filteredRecommended, filteredRecents))
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

  Widget _buildHeader() {
    final initials = widget.userName.isNotEmpty
        ? widget.userName.split(' ').map((word) => word[0]).take(2).join()
        : '';

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
                  widget.userName,
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
              child: CircleAvatar(
                backgroundColor: AppColor.secondary,
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                radius: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody(List<Map<String, dynamic>> filteredPopulars, List<Map<String, dynamic>> filteredRecommended, List<Map<String, dynamic>> filteredRecents) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          _buildSearch(),
          const SizedBox(height: 20),
          _buildCategories(),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          _buildPopulars(filteredPopulars),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          _buildRecommended(filteredRecommended),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          _buildRecent(filteredRecents),
          const SizedBox(height: 100),
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
          const SizedBox(width: 10),
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
                  Navigator.pushNamed(context, '/myAnnouncements');
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
            final propertyData = filteredPopulars[index];
            print('Navigating to PropertyDetailsPage with data: $propertyData');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PropertyDetailsPage(data: propertyData),
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

  List<Map<String, dynamic>> getFilteredProperties(int categoryIndex, List<Map<String, dynamic>> properties) {
    if (categoryIndex == 0) {
      return properties;
    } else {
      String category = categories[categoryIndex]['name'];
      return properties.where((property) => property['category'] == category).toList();
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
