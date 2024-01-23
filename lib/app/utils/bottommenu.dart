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
      height: widget.screenWidth * 0.11,
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: widget.screenWidth * 0.65,
          height: widget.screenWidth * 0.1,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(.25),
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
                        bottom:
                            index == widget.currentIndex ? 0 : size.width * .02,
                      ),
                      width: size.width * .32 / listOfIcons.length,
                      height:
                          index == widget.currentIndex ? size.width * .014 : 0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                    ),
                    Icon(
                      listOfIcons[index],
                      size: size.width * .06,
                      color: index == widget.currentIndex
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.outline,
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
