import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlockButtonWidget extends StatelessWidget {
  BlockButtonWidget(
      {Key? key,
     required this.title,
        required this.boxColors,
        required this.boxColors2,

      required this.onPressed,
      this.padd})
      : super(key: key);
  bool isgrad = true;
  Color boxColors;
  String title;
  Color boxColors2;


  // Icon
  final VoidCallback onPressed;
  EdgeInsetsGeometry? padd =
      EdgeInsets.symmetric(horizontal: 110, vertical: 14);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Stack(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
                color: boxColors2,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.black45,
                      spreadRadius: 0.5,
                      offset: Offset(3, 4))
                ]),
          ),
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                color: boxColors,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.black12,
                      spreadRadius: 0.3,
                      offset: Offset(
                        5,
                        3,
                      ))
                ]),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.normal,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(1, 2),
                            ),
                            Shadow(
                                color: Colors.green,
                                blurRadius: 2,
                                offset: Offset(0.5, 2))
                          ]),
                    )),
                // Row(
                //   mainAxisAlignment:
                //   MainAxisAlignment.center,
                //   crossAxisAlignment:
                //   CrossAxisAlignment.center,
                //   children: genratestar(
                //       _listCat![index].noOfstar!),
                // )
              ],
            ),
          ),
        ],
      ),

    );
  }
}



class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  })  : assert(errorDetails != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          child: Text(
            "يوجد خطأ ما الرجاء المحاولة لاحقاَ",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          padding: const EdgeInsets.all(8.0),
        ),
        color: Colors.red,
        margin: EdgeInsets.zero,
      ),
    );
  }
}