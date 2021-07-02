import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PageDetails extends StatefulWidget {
  String text;
  String image;
  String id;

  PageDetails(String this.text, String this.image, this.id);

  @override
  _PageDetailsState createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  var likeicon = FontAwesomeIcons.thumbsUp;
  var txtCont = TextEditingController();
  var counter = 0;
  List<String> _listComments = [];
  ProgressDialog pr;
  static Firestore fireStore;

  DocumentReference documentReference;
  DocumentReference documentReferenceUser;
  DocumentReference commentsReferenceUser;

  String noOfLikes = "";
  var listMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();

    fireStore = Firestore.instance;

    documentReference = fireStore.collection("texts").document("${widget.id}");
    commentsReferenceUser =
        fireStore.collection("texts").document("${widget.id}");

    getDefualtData();
    isUserLiked();
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        message: 'please wait ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: noOfLikes == ""
            ? Center(
                child: Text("Loading..."),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset(widget.image),
                              Container(
                                  child: Text(
                                widget.text,
                                style: TextStyle(fontSize: 20),
                              )),
                              Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        margin:
                                            EdgeInsets.only(top: 9, right: 6),
                                        padding: EdgeInsets.all(6),
                                        child: Text("$noOfLikes")),
                                    InkWell(
                                      onTap: () {
                                        likeButtom();
                                      },
                                      child: Icon(
                                        likeicon,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextField(
                                controller: txtCont,
                                decoration: InputDecoration(
                                    hintText: "write comment ...",
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.play_arrow),
                                        onPressed: () {
                                          String c = txtCont.text;

                                          addComment(c);
//                                    setState(() {
//                                      _listComments.add(c);
//                                    });
                                        })),
                              ),
                              StreamBuilder(
                                stream: Firestore.instance
                                    .collection("texts")
                                    .document("${widget.id}")
                                    .collection("users_comments")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    listMessage = snapshot.data.documents;

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(10.0),
                                      itemBuilder: (context, index) =>
                                          buildItem(
                                              index,
                                              snapshot.data.documents[index],
                                              snapshot.data),
                                      itemCount: snapshot.data.documents.length,
                                      reverse: true,
                                    );
                                  }
                                },
                              ),

//                              ListView.builder(
//                                itemCount: _listComments.length,
//                                shrinkWrap: true,
//                                reverse: true,
//                                itemBuilder: (context, i) {
//                                  return Row(
//                                    mainAxisAlignment:
//                                        MainAxisAlignment.spaceBetween,
//                                    children: <Widget>[
//                                      Container(
//                                        padding: EdgeInsets.all(20),
//                                        child: Text(_listComments[i]),
//                                      ),
//                                      Container(
//                                        child: InkWell(
//                                            onTap: () {
//                                              setState(() {
//                                                _listComments.removeAt(i);
//                                              });
//                                            },
//                                            child: Icon(Icons.delete)),
//                                      )
//                                    ],
//                                  );
//                                },
//                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void likeButtom() async {
    pr.show();

    if (likeicon == FontAwesomeIcons.solidThumbsUp) {
      await documentReference.setData(
        {
          'likes': '${int.parse(noOfLikes) - 1}',
        },
      );
      setState(() {
        likeicon = FontAwesomeIcons.thumbsUp;
        noOfLikes = "${int.parse(noOfLikes) - 1}";
      });
      await documentReferenceUser.setData({'isLiked': false});
      pr.hide();
    } else if (likeicon == FontAwesomeIcons.thumbsUp) {
      await documentReference.setData(
        {
          'likes': '${int.parse(noOfLikes) + 1}',
        },
      );
      await documentReferenceUser.setData({'isLiked': true});

      setState(() {
        likeicon = FontAwesomeIcons.solidThumbsUp;
        noOfLikes = "${int.parse(noOfLikes) + 1}";
      });
      pr.hide();
    }
  }

  void getDefualtData() async {
    documentReference.get().then((DocumentSnapshot ds) {
      String likes = ds.data["likes"];
      setState(() {
        this.noOfLikes = likes;
      });
    });
  }

  void getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("userID");
    documentReferenceUser = fireStore
        .collection("texts")
        .document("${widget.id}")
        .collection(id)
        .document("is_liked");
  }

  void isUserLiked() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("userID");
    documentReferenceUser = fireStore
        .collection("texts")
        .document("${widget.id}")
        .collection(id)
        .document("is_liked");
    documentReferenceUser.get().then((DocumentSnapshot ds) {
      if (!ds.exists) {
        setState(() {
          likeicon = FontAwesomeIcons.thumbsUp;
        });
      } else {
        bool likes = ds.data["isLiked"];
        if (likes) {
          setState(() {
            likeicon = FontAwesomeIcons.solidThumbsUp;
          });
        } else {
          setState(() {
            likeicon = FontAwesomeIcons.thumbsUp;
          });
        }
      }
    });
  }

  void addComment(String c) async {
    Uuid uuid = new Uuid();
    String id = uuid.v1();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.getString("userID");

    commentsReferenceUser.collection("users_comments").document(id).setData(
        {"comment": "${txtCont.text}", "user_id": "$user_id", "id": "$id"});
    txtCont.text = "";
  }

  buildItem(int index, document, data) {
    print(document['id']);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Text(document["comment"]),
        ),
        Row(
          children: <Widget>[
            InkWell(
                onTap: () {
                  startEdit(document['id']);
                },
                child: Icon(Icons.edit)),
            SizedBox(
              width: 10,
            ),
            Container(
              child: InkWell(
                  onTap: () {
                    removeComment(document['id']);
                  },
                  child: Icon(Icons.delete)),
            ),
          ],
        ),
      ],
    );
  }

  void removeComment(String document) async {
    commentsReferenceUser
        .collection("users_comments")
        .document("$document")
        .delete();
  }

  void startEdit(document) async {
    var editController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit your comment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: editController,
                  decoration:
                      InputDecoration(hintText: "Edit your comment ..."),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('submit'),
              onPressed: () {
                commentsReferenceUser
                    .collection("users_comments")
                    .document("$document")
                    .updateData({"comment": "${editController.text}"});
                editController.text="";
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
