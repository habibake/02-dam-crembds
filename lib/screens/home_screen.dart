import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = RecipeService().fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F6F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1B5E20),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Recetario',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 840),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFDCE7DD)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Platillos Ancestrales',
                        style: TextStyle(
                          color: Color(0xFF1B5E20),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'de Quintana Roo',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF526255)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Descubre los sabores originarios de nuestra tierra',
                        style: TextStyle(
                          color: Color(0xFF526255),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Text(
                  'Recetas disponibles',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF223B27),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Recipe>>(
                  future: _recipesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                  color: Color(0xFF1B5E20)),
                              SizedBox(height: 16),
                              Text('Cargando recetas...',
                                  style: TextStyle(color: Color(0xFF526255))),
                            ],
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.wifi_off,
                                  size: 56, color: Colors.grey),
                              const SizedBox(height: 12),
                              const Text(
                                'Error al cargar recetas',
                                style: TextStyle(
                                    color: Color(0xFF526255), fontSize: 16),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${snapshot.error}',
                                style: const TextStyle(
                                    color: Color(0xFF526255), fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1B5E20),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () => setState(() {
                                  _recipesFuture =
                                      RecipeService().fetchRecipes();
                                }),
                                icon: const Icon(Icons.refresh),
                                label: const Text('Reintentar'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final recipes = snapshot.data ?? [];

                    if (recipes.isEmpty) {
                      return const Center(
                        child: Text(
                          'No se encontraron recetas.',
                          style: TextStyle(color: Color(0xFF526255)),
                        ),
                      );
                    }

                    return Theme(
                      data: Theme.of(context).copyWith(
                        cardTheme: Theme.of(context).cardTheme.copyWith(
                              color: Colors.white,
                              shadowColor: Colors.transparent,
                            ),
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 88),
                        itemCount: recipes.length,
                        itemBuilder: (_, i) => RecipeCard(recipe: recipes[i]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
