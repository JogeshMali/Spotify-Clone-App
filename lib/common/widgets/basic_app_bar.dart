import 'package:flutter/material.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget ? title ,action ;
  final Color ? backgroundColor;
  final bool hideBack;
  const BasicAppBar({super.key, this.title, this.action, this.backgroundColor,  this.hideBack =false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [action?? Container()],
        title: title ?? Text(''),
        leading: hideBack ?null : IconButton(onPressed: (){}, icon: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: context.isDarkMode?Colors.white.withOpacity(0.03):Colors.black.withOpacity(0.04),
            shape: BoxShape.circle
          ),
          child: IconButton(onPressed : ()=>Navigator.pop(context),icon:Icon(Icons.arrow_back_ios_new,size: 15,color: context.isDarkMode ? Colors.white : Colors.black,)),
        )),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
