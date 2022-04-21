import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/model/futsal.dart';
import 'package:hamro_futsal/routes.dart';
import 'package:hamro_futsal/utils/baseurl.dart';

class FutsalCard extends StatelessWidget {
  const FutsalCard({
    Key? key,
    required this.futsal,
  }) : super(key: key);

  final Futsal futsal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(GetRoutes.futsalDesc, arguments: futsal);
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(baseurl + futsal.image!)),
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              futsal.name!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 21,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: false,
                            ),
                            Text(
                              '${futsal.side}A-side',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Color(0xff525252),
                                fontWeight: FontWeight.w700,
                              ),
                              softWrap: false,
                            )
                          ],
                        ),
                        Text(
                          futsal.address!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xff9c9c9c),
                            fontWeight: FontWeight.w500,
                          ),
                          softWrap: false,
                        ),
                        Text(
                          futsal.contact!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xff9c9c9c),
                            fontWeight: FontWeight.w500,
                          ),
                          softWrap: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Rs. ${futsal.price!}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xff525252),
                            fontWeight: FontWeight.w700,
                          ),
                          softWrap: false,
                        ),
                        Text(
                          futsal.description!,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: Color(0xff242424),
                          ),
                          softWrap: false,
                        )
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
