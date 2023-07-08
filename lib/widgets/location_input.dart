import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.getLoc});
  final Function(LocationData locationData) getLoc;
  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  var _isGettingLocation = false;
  LocationData? _locationData;
  void _getCurrentLoc() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();
    setState(() {
      _locationData = locationData;
    });
    setState(() {
      _isGettingLocation = true;
    });

    widget.getLoc(_locationData!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      "No location selected yet",
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
    if (_isGettingLocation) {
      content = Expanded(
        child: Column(
          children: [
            Text(
              "Latitude : ${_locationData!.latitude}",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Longitude : ${_locationData!.longitude}",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            content,
            const SizedBox(
              height: 10,
            ),
            TextButton.icon(
              onPressed: _getCurrentLoc,
              icon: const Icon(Icons.location_on_rounded),
              label: const Text("Obtain Current Location"),
            ),
          ],
        )
      ],
    );
  }
}
