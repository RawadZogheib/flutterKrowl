import 'package:flutter/material.dart';
import 'package:Krowl/globals/globals.dart' as globals;

class ChatDetailPageAppBar extends StatelessWidget implements PreferredSizeWidget{
  var username;
  var status;
  ChatDetailPageAppBar({
   required this.username,
    required this.status,
});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back,color: Colors.black,),
              ),
              SizedBox(width: 2,),
              CircleAvatar(
                backgroundImage: AssetImage("Assets/userImage1.jpeg"),
                maxRadius: 20,
              ),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(username ,style: TextStyle(fontWeight: FontWeight.w600),),
                    SizedBox(height: 6,),
                    Text(status,style: TextStyle(color: globals.blue1,fontSize: 12),),
                  ],
                ),
              ),
              Icon(Icons.more_vert,color: Colors.grey.shade700,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}