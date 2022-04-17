import 'package:flutter/material.dart';
//import '../modal/dummydata.dart';
import '../modal/user.dart';
//import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class PostWidget extends StatefulWidget {
  //const PostWidget({Key? key}) : super(key: key);
  final Posts p;
  PostWidget({required this.p});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    //final curuser = Provider.of<DummyData>(context);
    //final u = curuser.loggedin;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Text('KY'),
            backgroundColor: Colors.green,
            radius: 20,
          ),
          title: Text(widget.p.crname), //creator name from id
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
          horizontalTitleGap: 20,
        ),
        //Text,
        //Container(child: ,),
        Padding(
          padding: EdgeInsets.all(5),
          child: ReadMoreText(
            widget.p.txt,
            trimLines: 2,
            colorClickableText: Colors.black,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...Show more',
            trimExpandedText: 'Show less',
            style: TextStyle(color: Colors.black),
            moreStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
            lessStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),

        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
          ),
          child: Image.network(
            widget.p.img,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
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
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.comment),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.send),
            ),
          ],
        ),
        Text(
          widget.p.postid,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        )
      ],
    );
  }
}
