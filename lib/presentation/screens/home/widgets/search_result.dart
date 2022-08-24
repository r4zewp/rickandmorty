import 'package:rickandmorty_ca_test/domain/entities/person_entity/person_entity.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty_ca_test/presentation/screens/home/widgets/person_cache_image_widget.dart';
import 'package:rickandmorty_ca_test/presentation/screens/person_detail/person_detail_page.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.searchResult}) : super(key: key);

  final PersonEntity searchResult;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PersonDetailPage(person: searchResult),
        ));
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PersonCachedImage(
                height: 300,
                width: double.infinity,
                url: searchResult.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                searchResult.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                searchResult.location.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
