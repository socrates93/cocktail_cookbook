import 'package:flutter/material.dart';

class DrinkCardWidget extends StatelessWidget {
  final double width;
  final double height;

  const DrinkCardWidget({
    super.key,
    this.width = double.maxFinite,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          print("hola");
        },
        child: SizedBox(
          width: width,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Image.network(
                  "https://thecocktaildb.com/images/ingredients/gin.png",
                  fit: BoxFit.fitHeight,
                  loadingBuilder: (BuildContext _, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;

                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  padding: const EdgeInsets.all(16),
                  child: const Text("hola"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
