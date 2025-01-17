import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/core/di.dart';
import 'package:tourist_app/core/style/style_extensions.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_primary_button.dart';
import 'package:tourist_app/features/locations/domain/model/location.dart';
import 'package:tourist_app/features/locations/presentation/favorite_list/controller/state/favorite_list_state.dart';
import 'package:tourist_app/features/locations/presentation/widget/star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationDetailScreen extends ConsumerWidget {
  const LocationDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final location = ModalRoute.of(context)?.settings.arguments as Location;
    final favoriteState = ref.watch(favoriteListNotifier);

    bool isFavorite(final Location location){
      if (favoriteState is FilledState){
        return favoriteState.favorites.contains(location);
      } else {
        return false;
      }
    }

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Image.network(
              location.imageUrl,
              height: screenSize.height / 2.5,
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: context.colorBackground,
                  child: IconButton(
                    color: context.colorGradientEnd,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.chevron_left_rounded, size: 35),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenSize.height / 2.7),
              padding: const EdgeInsets.all(20),
              width: double.maxFinite,
              //height: screenSize.height,
              decoration: BoxDecoration(
                color: context.colorBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.title,
                    style: context.textTitle,
                  ),
                  Text(location.address, style: context.textSubtitle),
                  const SizedBox(height: 20),
                  Text("Rating", style: TextStyle(fontWeight: FontWeight.bold)),
                  StarRating(
                    rating: location.rating,
                    activeStar: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [context.colorGradientBegin, context.colorGradientEnd],
                      ).createShader(bounds),
                      child: Icon(Icons.star, color: context.colorGradientBegin, size: 28),
                    ),
                    inactiveStar: Icon(Icons.star, color: Colors.grey, size: 28),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    location.description,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Spacer(),
                  CustomPrimaryButton(
                    onPressed: () => Platform.isAndroid
                        ? _launchAndroidMaps(context, location.lat, location.lng, location.title)
                        : _launchIOSMaps(context, location.lat, location.lng),
                    child: Text(
                      'Show on maps',
                      style: context.textButton.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenSize.height / 2.7 - 30,
              right: 20,
              child: GestureDetector(
                onTap: () => ref.read(favoriteListNotifier.notifier).setAsFavorite(location),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(209, 116, 56, 1),
                        Color.fromRGBO(157, 44, 86, 1)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      isFavorite(location) ? Icons.favorite : Icons.favorite_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _launchIOSMaps(BuildContext context, final double latitude, final double longitude) async {
  try {
    final url = Uri.parse('maps:$latitude,$longitude?q=$latitude,$longitude');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  } catch (error) {
    if (context.mounted) {
      final snackBar = SnackBar(content: Text("Cannot open maps app."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

void _launchAndroidMaps(BuildContext context, final double latitude, final double longitude, final String title)
async {
  try {
    final url = Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude($title)');
    await launchUrl(url);
  } catch (error) {
    if (context.mounted) {
      final snackBar = SnackBar(content: Text("Cannot open maps app."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}