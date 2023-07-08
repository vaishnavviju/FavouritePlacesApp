import 'package:favplacesapp/providers/userplaces.dart';
import 'package:favplacesapp/screens/addplace.dart';
import 'package:favplacesapp/widgets/placelist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceListScreen extends ConsumerStatefulWidget {
  const PlaceListScreen({super.key});
  @override
  ConsumerState<PlaceListScreen> createState() {
    return _PlaceListScreenState();
  }
}

class _PlaceListScreenState extends ConsumerState<PlaceListScreen> {
  late Future<void> _futurePlaces;
  @override
  void initState() {
    super.initState();
    _futurePlaces = ref.read(userPlacesProvider.notifier).loadPlace();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : PlacesList(
                        data: userPlaces,
                      ),
            future: _futurePlaces,
          )),
    );
  }
}
