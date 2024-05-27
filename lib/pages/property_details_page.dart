import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PropertyDetailsPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const PropertyDetailsPage({super.key, required this.data});

  @override
  PropertyDetailsPageState createState() => PropertyDetailsPageState();
}

class PropertyDetailsPageState extends State<PropertyDetailsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 330,
            child: PageView.builder(
              controller: _pageController,
              itemCount: (widget.data["images"] as List<String>?)?.length ?? 1,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return Image.network(
                  (widget.data["images"] as List<String>?)?[index] ??
                      widget.data["image"] ??
                      "",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          // Gradiente para a imagem
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 330,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
          // Indicadores de página
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                (widget.data["images"] as List<String>?)?.length ?? 1,
                (int index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8.0,
                    width: _currentPage == index ? 16.0 : 8.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.white : Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  );
                },
              ),
            ),
          ),
          // Conteúdo principal
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(),
                ),
                leading: _buildIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  _buildIconButton(
                    icon: Icons.share,
                    onPressed: () {
                      // Lógica para compartilhar
                    },
                  ),
                  _buildIconButton(
                    icon: widget.data["is_favorited"] == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    onPressed: () {
                      // Lógica para favoritar
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 0.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.data["title"] ?? "Nome não disponível",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "MT ${widget.data["price"] ?? "Preço não disponível"}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.grey, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            widget.data["location"] ??
                                "Localização não disponível",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFeatureIcon(FontAwesomeIcons.bed, "Quartos",
                                widget.data["bedRooms"]?.toString() ?? "4"),
                            const SizedBox(width: 16),
                            _buildFeatureIcon(FontAwesomeIcons.bath, "WC",
                                widget.data["bathRooms"]?.toString() ?? "3"),
                            const SizedBox(width: 16),
                            _buildFeatureIcon(
                                FontAwesomeIcons.kitchenSet,
                                "Cozinha",
                                widget.data["kitchens"]?.toString() ?? "1"),
                            const SizedBox(width: 16),
                            _buildFeatureIcon(
                                FontAwesomeIcons.couch,
                                "Sala de estar",
                                widget.data["livingRooms"]?.toString() ?? "2"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Descrição",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.data["description"] ??
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/86506519?v=4",
                                  ),
                                  radius: 30,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Radek Buanali",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Dono",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Lógica para marcar visita
                                    },
                                    child: const Text("Marcar visita"),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Lógica para ligar
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: const Text(
                                      "Ligar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label, String value) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 154, 209, 255),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: FaIcon(icon, size: 32, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
