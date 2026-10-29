import 'package:flutter/material.dart';

void main() => runApp(const PattukkottaiApp());

// ---------------------------------------------------------------
// DATA  (edit / add your own places and details here)
// ---------------------------------------------------------------
class Place {
  final String name;
  final String info;
  const Place(this.name, this.info);
}

class Category {
  final String emoji;
  final String title;
  final Color color;
  final List<Place> places;
  const Category(this.emoji, this.title, this.color, this.places);

  String get summary => places.map((p) => p.name).join(', ');
}

const String defaultInfo = 'Details coming soon. Add address, timings and phone here.';

const List<Category> categories = [
  Category('🏫', 'Schools', Color(0xFF5C6BC0), [
    Place('Golden Int.', defaultInfo),
    Place('Mount Carmel', defaultInfo),
    Place('Bon Secours', defaultInfo),
  ]),
  Category('🎓', 'Colleges', Color(0xFF26A69A), [
    Place('Meenakshi', defaultInfo),
    Place('Enathi Rajappa', defaultInfo),
    Place('Polytechnic', defaultInfo),
  ]),
  Category('🍿', 'Theatres', Color(0xFFEF5350), [
    Place('Annapurna A/C', defaultInfo),
    Place('New Rajamani', defaultInfo),
    Place('AYYA', defaultInfo),
  ]),
  Category('🌳', 'Parks & Memorials', Color(0xFF66BB6A), [
    Place('Gandhi Park', defaultInfo),
    Place('Kalyanasundaram Park', defaultInfo),
  ]),
  Category('🌊', 'Beaches', Color(0xFF29B6F6), [
    Place('Manora Beach', defaultInfo),
    Place('Pudupattinam Beach', defaultInfo),
  ]),
];

// ---------------------------------------------------------------
// APP
// ---------------------------------------------------------------
class PattukkottaiApp extends StatelessWidget {
  const PattukkottaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pattukkottai Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00796B)),
        scaffoldBackgroundColor: const Color(0xFFF4F7F6),
      ),
      home: const HomeScreen(),
    );
  }
}

// ---------------------------------------------------------------
// HOME SCREEN
// ---------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 190,
            backgroundColor: const Color(0xFF00796B),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 14),
              title: const Text(
                'Pattukkottai Guide',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF004D40), Color(0xFF26A69A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 60, right: 20),
                    child: Text('📍', style: TextStyle(fontSize: 70)),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: Text(
                'Welcome to Pattukkottai, Thanjavur!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                'Tap a category to explore places',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => CategoryCard(category: categories[index]),
                childCount: categories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        elevation: 2,
        shadowColor: category.color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryScreen(category: category),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Hero(
                  tag: category.title,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: category.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        category.emoji,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        category.summary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: category.color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// CATEGORY SCREEN (opens when you tap a category)
// ---------------------------------------------------------------
class CategoryScreen extends StatelessWidget {
  final Category category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: category.color,
        foregroundColor: Colors.white,
        title: Text(category.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Hero(
              tag: category.title,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 90,
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(category.emoji,
                      style: const TextStyle(fontSize: 46)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '${category.places.length} places in ${category.title}',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 16),
          ...category.places.asMap().entries.map((entry) {
            final place = entry.value;
            return Card(
              elevation: 1.5,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: CircleAvatar(
                  backgroundColor: category.color,
                  foregroundColor: Colors.white,
                  child: Text('${entry.key + 1}'),
                ),
                title: Text(place.name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: Icon(Icons.info_outline, color: category.color),
                onTap: () => _showDetails(context, place),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, Place place) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(category.emoji, style: const TextStyle(fontSize: 34)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    place.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(category.title, style: TextStyle(color: category.color)),
            const Divider(height: 28),
            Text(place.info, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: category.color,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}