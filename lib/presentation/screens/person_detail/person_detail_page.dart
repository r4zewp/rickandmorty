import 'package:flutter/material.dart';
import 'package:rickandmorty_ca_test/common/colors.dart';
import 'package:rickandmorty_ca_test/domain/entities/person_entity/person_entity.dart';
import 'package:rickandmorty_ca_test/presentation/screens/home/widgets/person_cache_image_widget.dart';

class PersonDetailPage extends StatelessWidget {
  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character - ${person.name}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            PersonCachedImage(
              url: person.image,
              width: 260,
              height: 260,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: person.status == "Alive" ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  person.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            _personDescription('Gender', person.gender),
            const SizedBox(
              height: 16,
            ),
            _personDescription(
                'Number of episodes', person.episodes.length.toString()),
            const SizedBox(
              height: 16,
            ),
            _personDescription('Species', person.species),
            const SizedBox(
              height: 16,
            ),
            _personDescription('Last known location', person.location.name),
            const SizedBox(
              height: 16,
            ),
            _personDescription('Origin', person.origin.name),
            const SizedBox(
              height: 16,
            ),
            _personDescription('Was created', person.created.toString()),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _personDescription(String text, String subText) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(color: AppColors.greyColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          subText,
          style: const TextStyle(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
