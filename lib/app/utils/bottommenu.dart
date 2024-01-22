import 'package:donative/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class Menu extends StatefulWidget {
  final double screenWidth;
  final int currentIndex;
  final Function(int) onIconPressed;

  const Menu({
    Key? key,
    required this.screenWidth,
    required this.currentIndex,
    required this.onIconPressed,
  }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<IconData> listOfIcons = [
    IconlyBold.home,
    IconlyBold.profile,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: widget.screenWidth,
      height: 70,
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: widget.screenWidth * .65,
          height: 55,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF196C32).withOpacity(.25),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(listOfIcons.length, (index) {
              return InkWell(
                onTap: () {
                  widget.onIconPressed(index);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      margin: EdgeInsets.only(
                        bottom: index == widget.currentIndex ? 0 : size.width * .029,
                      ),
                      width: size.width * .32 / listOfIcons.length,
                      height: index == widget.currentIndex
                          ? size.width * .014
                          : 0,
                      decoration: BoxDecoration(
                        color: Color(0xFF89F8C6),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                    ),
                    Icon(
                      listOfIcons[index],
                      size: size.width * .06,
                      color: index == widget.currentIndex
                          ? Color(0xFF89F8C6)
                          : Colors.black38,
                    ),
                    SizedBox(height: size.width * .02),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

