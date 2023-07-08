import 'dart:io';
import 'package:favplacesapp/models/place.dart';
import 'package:location/location.dart';
import 'package:favplacesapp/providers/userplaces.dart';
import 'package:favplacesapp/widgets/image_input.dart';
import 'package:favplacesapp/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titlecontroller = TextEditingController();
  File? _selimg;
  PlaceLoc? _selLoc;
  void _savePlace() {
    final inputText = _titlecontroller.text;
    if (inputText.isEmpty || _selimg == null) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(inputText, _selimg!, _selLoc!);
    Navigator.of(context).pop();
  }

  void dispose() {
    _titlecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titlecontroller,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 13,
            ),
            ImageInput(pickimage: (image) {
              _selimg = image;
            }),
            const SizedBox(
              height: 13,
            ),
            LocationInput(
              getLoc: (location) {
                _selLoc = PlaceLoc(
                    latitude: location.latitude as double,
                    longitude: location.longitude as double);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: _savePlace,
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
