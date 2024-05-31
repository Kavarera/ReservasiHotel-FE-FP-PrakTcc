import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusHotelItemWidget extends StatelessWidget {
  final String title;
  final String data;
  final IconData? icon;
  const StatusHotelItemWidget(
      {super.key, required this.title, required this.data, this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: GoogleFonts.firaSans(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis, // add this
            ),
          ),
          const Divider(
            height: 15,
            thickness: 2,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      data,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis, // add this
                      maxLines: 2, // add this
                    ),
                  ),
                ),
                if (icon != null)
                  Icon(
                    icon,
                    size: 100,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ReportSummary extends StatelessWidget {
  final List<String> titles;
  final List<String> datas;
  final List<IconData?>? icons;

  const ReportSummary({
    super.key,
    required this.titles,
    required this.datas,
    this.icons,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600
        ? 3
        : 1; // adjust the number of columns based on screen width

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: titles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 3 / 1.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return StatusHotelItemWidget(
          title: titles.elementAt(index),
          data: datas.elementAt(index),
          icon: icons?.elementAt(index),
        );
      },
    );
  }
}
