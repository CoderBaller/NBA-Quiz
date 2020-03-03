import 'package:flutter/material.dart';
import 'package:nbaquiz/constants.dart';
import 'package:nbaquiz/screens/profile.dart';
import 'package:nbaquiz/screens/quiz.dart';
import 'package:nbaquiz/services/globals.dart';
import 'package:nbaquiz/services/models.dart';
import 'package:nbaquiz/services/storage.dart';
import 'package:nbaquiz/shared/loader.dart';
import 'package:nbaquiz/shared/progress_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopicsScreen extends StatelessWidget {
  static String id = 'topics_screen';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.topicsRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          List<Topic> topics = snap.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Topics'),
              actions: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.userCircle),
                  onPressed: () =>
                      Navigator.pushNamed(context, ProfileScreen.id),
                )
              ],
            ),
            drawer: TopicDrawer(topics: snap.data),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
          );
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}

class TopicItem extends StatefulWidget {
  final Topic topic;

  TopicItem({Key key, this.topic}) : super(key: key);

  @override
  _TopicItemState createState() => _TopicItemState();
}

class _TopicItemState extends State<TopicItem> {
  final StorageService storage = StorageService();

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  Future<void> _getImage() async {
    if (widget.topic.imgUrl == null) {
      widget.topic.imgUrl = await storage.getUrl(widget.topic.img);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: widget.topic.img,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      TopicScreen(topic: widget.topic),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.topic.imgUrl == null
                    ? Center(
                        heightFactor: 2.5,
                        child: CircularProgressIndicator(),
                      )
                    : Image.network(
                        widget.topic.imgUrl,
                        fit: BoxFit.contain,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          widget.topic.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: kMainColor),
                        ),
                      ),
                    ),
                  ],
                ),
                // )
                TopicProgress(topic: widget.topic),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;

  TopicScreen({this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          topic.title,
        ),
      ),
      body: ListView(children: [
        Hero(
          tag: topic.img,
          child: Image.network('${topic.imgUrl}',
              width: MediaQuery.of(context).size.width),
        ),
        QuizList(topic: topic),
      ]),
    );
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;
  QuizList({Key key, this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: topic.quizzes.map((quiz) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        color: kBlueColor,
        margin: EdgeInsets.symmetric(vertical: 2),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => QuizScreen(quizId: quiz.id),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                quiz.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                quiz.description,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              leading: QuizBadge(topic: topic, quizId: quiz.id),
            ),
          ),
        ),
      );
    }).toList());
  }
}

class TopicDrawer extends StatelessWidget {
  final List<Topic> topics;
  TopicDrawer({Key key, this.topics});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: kMainColor,
      ),
      child: Drawer(
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: topics.length,
            itemBuilder: (BuildContext context, int idx) {
              Topic topic = topics[idx];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 8, bottom: 4),
                    child: Text(
                      topic.title,
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  QuizList(topic: topic)
                ],
              );
            },
            separatorBuilder: (BuildContext context, int idx) => Divider()),
      ),
    );
  }
}
