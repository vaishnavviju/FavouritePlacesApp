import 'package:favplacesapp/models/place.dart';
import 'package:favplacesapp/screens/placesdetail.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  PlacesList({super.key, required this.data});
  List<Place> data;
  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Text(
          "No place added",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(data[index].image),
        ),
        title: Text(
          data[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground, fontSize: 20),
        ),
        subtitle: Expanded(
          child: Row(
            children: [
              Text(
                'Latitude : ${data[index].location.latitude}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 14),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Longitude : ${data[index].location.longitude}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 14),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlaceDetailScreen(place: data[index]),
            ),
          );
        },
      ),
    );
  }
}
