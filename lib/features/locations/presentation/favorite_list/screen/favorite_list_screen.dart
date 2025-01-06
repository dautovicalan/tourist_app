import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tourist_app/core/di.dart';
import 'package:tourist_app/core/style/style_extensions.dart';
import 'package:tourist_app/features/locations/presentation/favorite_list/controller/state/favorite_list_state.dart';
import 'package:tourist_app/features/locations/presentation/location_list/widget/location_card.dart';

class FavoriteListScreen extends ConsumerWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoriteListNotifier);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Favorites", style: context.textTitle),
              const SizedBox(height: 20),
              switch (state) {
                FilledState(favorites: var list) => Expanded(
                  child: ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 15),
                    itemBuilder: (context, index) => LocationCard(list[index]),
                  ),
                ),
                EmptyState() => Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/images/no_favorites.png", width: 200),
                        const SizedBox(height: 20),
                        Text(
                          "There are no favorites yet...",
                          style: context.textSubtitle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Here you will see all your favorite sights. Mark them as favorite by pressing the heart icon.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                LoadingState() => Expanded(
                  child: Center(
                    child: Lottie.asset('assets/animations/loading_sights.json', height: 50),
                  ),
                )
              }
            ],
          ),
        ),
      ),
    );
  }
}