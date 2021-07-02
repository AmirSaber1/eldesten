import 'package:eldesten/PageDetails.dart';
import 'package:flutter/material.dart';


import 'dataModel.dart';

class Home extends StatefulWidget {
  String name;
  String password;

  Home(this.name, this.password);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> texts = [
    "Amethyst is a purple variety of crystalline quartz. It is the world's most popular purple gemstone and has been used for thousands of years. This amethyst is tumbled from crystals that grew with zones of white quartz alternating with purple amethyst. That is the cause of the banded pattern. Some people call it chevron amethyst because some pieces have a V shaped color pattern in the shape of a chevron.",
    "Jasper is a semi-translucent to opaque variety of chalcedony that often accepts a very high polish. That is why it is so frequently seen in gemstone and lapidary products. It is also a relatively inexpensive stone, which makes it popular in the marketplace. The material that we have here is brilliant red.",
    "Aventurine, sometimes called aventurine quartz, is a variety of translucent quartz that exhibits a glittery appearance when it is moved under a light or when the angle of observation changes. When light penetrates the stone, some of it encounters tiny mineral crystals which reflect the light and make the stone sparkle  In green aventurine the tiny crystals are usually a mineral known as fuchsite, a green mica that is highly reflective. The fuchsite crystals give green aventurine both its color and its glittery appearance  known aventurescence.",
    "Apache Tears are round nodules of an igneous rock known as obsidian that can be polished to a beautiful jet-black luster. If you hold them up to the light, you can see that they are a translucent to sometimes transparent glass created in nature by a volcanic eruption. Tiny amounts of volcanic ash are embedded within the glass.",
    "Beryl is a silicate mineral that contains small amounts of beryllium. It occurs in a variety of colors, and gem-quality beryl is named according to its color. Bright green is known as emerald, blue (like this material here) is known as aquamarine, yellow and yellowish green are known as heliodor and pink is known as morganite. Some beryl is colorless and is known as goshenite  So, is this material really aquamarine? We sent a sample to the Gemological Institute of America's laboratory and asked them to identify it. They identified it as aquamarine.",
    "Yellow Jasper is an attractive material that ranges from a cream yellow to a rich yellow-brown , Yellow-brown is a very common color of jasper that is found at many locations around the world."
  ];
  List<String> images = [
    "assets/banded-amethyst.jpg",
    "assets/red.jpg",
    "assets/green.jpg",
    "assets/black.jpg",
    "assets/blue.jpg",
    "assets/Yellow.jpg"
  ];
  List<String> catogries = new List();
  List<dataModel> listSearch = [];
  List<dataModel> filteredCategories = new List();
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Logo
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Image.asset(
                      "assets/logo.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        "Edelsten",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
              //Search Text
              Container(
                margin: EdgeInsets.only(left: 30, top: 40),
                child: Text(
                  "Search",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              //Search Bar
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: _filter,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(17),
                      hintText: "Search an article",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  )),
              //First Image Row
              getSearchBody()
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void initState() {
    getSearchData();
    super.initState();
  }

  _HomeState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredCategories = listSearch;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          filteredCategories = listSearch;
        });
      }
    });
  }

  Widget getBodyView() {
    if (_filter.text == "") {
      return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //Logo
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20),
                  child: Image.asset(
                    "assets/logo.png",
                    width: 80,
                    height: 80,
                  ),
                ),
                //Search Text
                Container(
                  margin: EdgeInsets.only(left: 80, top: 40),
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 40, color: Colors.black),
                  ),
                ),
                //Search Bar
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    margin: EdgeInsets.only(top: 40),
                    child: TextField(
                      controller: _filter,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(17),
                        hintText: "Search an article",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                    )),
                //First Row
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PageDetails(
                                texts[0], "assets/banded-amethyst.jpg","0")));
                      },
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            "assets/banded-amethyst.jpg",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 50),
                            child: Text(
                              "Amethyst",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PageDetails(texts[1], "assets/red.jpg","1")));
                      },
                      child: Stack(
                        children: <Widget>[
                          Image.asset("assets/red.jpg",
                              width: 80, height: 80, fit: BoxFit.cover),
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 53),
                            child: Text(
                              "Red Jasper",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PageDetails(texts[2], "assets/green.jpg","2")));
                      },
                      child: Stack(
                        children: <Widget>[
                          Image.asset("assets/green.jpg",
                              width: 80, height: 80, fit: BoxFit.cover),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 55),
                            child: Text(
                              "Green Aventurine",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
                //Second Row
                ,
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PageDetails(texts[3], "assets/black.jpg","3")));
                      },
                      child: Stack(
                        children: <Widget>[
                          Image.asset("assets/black.jpg",
                              width: 80, height: 80, fit: BoxFit.cover),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 50),
                            child: Text(
                              "Apache Tears",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PageDetails(texts[4], "assets/blue.jpg","4")));
                      },
                      child: Stack(
                        children: <Widget>[
                          Image.asset("assets/blue.jpg",
                              width: 80, height: 80, fit: BoxFit.cover),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 49),
                            child: Text(
                              "Aquamarine",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    } else {}
  }

  void getSearchData() {
    listSearch.add(dataModel("Amethyt", 0));
    listSearch.add(dataModel("Red Jasper", 1));
    listSearch.add(dataModel("Green Aventurine", 2));
    listSearch.add(dataModel("Apache Tears", 3));
    listSearch.add(dataModel("Aquamarine", 4));
    listSearch.add(dataModel("Yellow Jasper", 5));
  }

  getSearchBody() {
    if (_filter.text == "") {
      return Container(
        margin: EdgeInsets.only(left: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageDetails(texts[0], "assets/purple.jpg","0")));
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        "assets/banded-amethyst.jpg",
                        width: 125,
                        height: 125,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 50),
                        child: Text(
                          "Amethyst",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageDetails(texts[1], "assets/red.jpg","1")));
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Image.asset("assets/red.jpg",
                          width: 125, height: 125, fit: BoxFit.cover),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 53),
                        child: Text(
                          "Red Jasper",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageDetails(texts[2], "assets/green.jpg","2")));
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Image.asset("assets/green.jpg",
                          width: 125, height: 125, fit: BoxFit.cover),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 55),
                        child: Text(
                          "Green Aventurine",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            //Second Image Row
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageDetails(texts[3], "assets/black.jpg","3")));
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Image.asset("assets/black.jpg",
                          width: 125, height: 125, fit: BoxFit.cover),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 50),
                        child: Text(
                          "Apache Tears",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageDetails(texts[4], "assets/blue.jpg","4")));
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Image.asset("assets/blue.jpg",
                          width: 125, height: 125, fit: BoxFit.cover),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 49),
                        child: Text(
                          "Aquamarine",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PageDetails(texts[5], "assets/Yellow.jpg","5")));
                  },
                  child: Material(
                    child: Stack(
                      children: <Widget>[
                        Image.asset("assets/Yellow.jpg",
                            width: 125, height: 125, fit: BoxFit.cover),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 55),
                          child: Text(
                            "Yellow jasber",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    } else {
      List<dataModel> tempList = new List();
      for (int i = 0; i < filteredCategories.length; i++) {
        if (filteredCategories[i]
            .get_name()
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(dataModel(filteredCategories[i].get_name(),
              filteredCategories[i].get_id()));
        } else {
          print("not con");
        }
      }
      filteredCategories = tempList;

      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: filteredCategories.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              new ListTile(
                title: Text(
                  filteredCategories[index].get_name(),
                  style: TextStyle(fontSize: 19),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageDetails(
                              texts[filteredCategories[index].get_id()],
                              images[filteredCategories[index].get_id()],"$index")));
                },
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          );
        },
      );
    }
  }
}
