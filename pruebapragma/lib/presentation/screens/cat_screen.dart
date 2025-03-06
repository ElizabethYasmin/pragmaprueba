import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cat_provider.dart';
import 'package:go_router/go_router.dart';

class CatScreen extends ConsumerStatefulWidget {
  const CatScreen({super.key});

  @override
  _CatScreenState createState() => _CatScreenState();
}

class _CatScreenState extends ConsumerState<CatScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  List<String> suggestions = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      ref.read(catPaginationProvider.notifier).fetchCats();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cats = ref.watch(catPaginationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catbreeds',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                      suggestions = cats
                          .where((cat) => cat.name.toLowerCase().contains(searchQuery))
                          .map((cat) => cat.name)
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar raza...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                if (suggestions.isNotEmpty && searchQuery.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(suggestions[index]),
                          onTap: () {
                            setState(() {
                              _searchController.text = suggestions[index];
                              searchQuery = suggestions[index].toLowerCase();
                              suggestions.clear();
                            });
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: cats.length,
              itemBuilder: (context, index) {
                final cat = cats[index];
                if (!cat.name.toLowerCase().contains(searchQuery)) {
                  return const SizedBox.shrink();
                }
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          cat.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            context.go('/detail-scroll', extra: cat);
                          },
                          child: const Text(
                            'Más...',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          cat.url,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 200),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Origen: ',
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .copyWith(fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: cat.origin,
                                    style: DefaultTextStyle.of(context).style,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: 'Temperamento: ',
                                  style: DefaultTextStyle.of(context)
                                      .style
                                      .copyWith(fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: cat.temperament,
                                      style: DefaultTextStyle.of(context).style,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
