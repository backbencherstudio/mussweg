import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../../view_model/mussweg/mussweg_product_screen_provider.dart';

class LocationPickerScreen extends StatelessWidget {
  const LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();

    return Consumer<MusswegProductScreenProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: Stack(
            children: [

              // -------- MAP --------
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: provider.selectedLocation,
                  initialZoom: 16,
                  onTap: (tapPos, latlng) {
                    provider.setSelectedLocation(latlng);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                    'https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 50,
                        height: 50,
                        point: provider.selectedLocation,
                        child: const Icon(Icons.location_pin,
                            size: 50, color: Colors.red),
                      )
                    ],
                  ),
                ],
              ),

              // -------- SEARCH BAR --------
              Positioned(
                top: 60,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(12),
                      child: TextField(
                        controller: provider.searchController,
                        decoration: const InputDecoration(
                          hintText: "Search address",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        onChanged: (value) => provider.searchPlaces(value),
                      ),
                    ),

                    // -------- SEARCH RESULTS DROPDOWN --------
                    if (provider.searchResults.isNotEmpty)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.searchResults.length,
                          itemBuilder: (context, index) {
                            final place = provider.searchResults[index];
                            return ListTile(
                              title: Text(place["display_name"]),
                              onTap: () {
                                provider.selectSearchResult(place);
                                // Move map to new location
                                mapController.move(provider.selectedLocation, 16);
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),

              // -------- PIN HERE BUTTON --------
              Positioned(
                bottom: 30,
                left: 40,
                right: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    await provider.fetchAndStoreAddress();

                    Navigator.pop(context, {
                      "lat": provider.selectedLocation.latitude,
                      "lng": provider.selectedLocation.longitude,
                      "address": provider.currentAddress,
                    });
                  },
                  child: const Text(
                    "PIN here",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
