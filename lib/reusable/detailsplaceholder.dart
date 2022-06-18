import 'package:flutter/material.dart';
import 'package:insight1/reusable/placeholder.dart';

class DetailsPlaceholder extends StatelessWidget {
  const DetailsPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Column(
        children: [
          Opacity(
            opacity: 0.4,
            child: ContentPlaceHolder(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5)
              ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ContentPlaceHolder(height: 20,width: MediaQuery.of(context).size.width*0.5,),
                    ),
                    ContentPlaceHolder(height: 20,width: MediaQuery.of(context).size.width*0.3,)
                ],
              ),
            ),
        ],
      ),
    );
  }
}
