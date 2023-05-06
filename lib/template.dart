import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({Key? key}) : super(key: key);

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Course",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.black),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...courses
                  .map((course) => Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Coursecard(course: course),
                      ))
                  .toList(),
            ],
          ),
        )
      ])),
    );
  }
}

class Coursecard extends StatelessWidget {
  const Coursecard({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      height: 280,
      width: 260,
      decoration: BoxDecoration(
        color: course.bgcolor,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Text(
                    course.description,
                    style: TextStyle(color: Colors.white60),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
            width: 40,
            child: Image.asset(
              course.iconSrc,
              scale: 0.001,
            ),
          )
        ],
      ),
    );
  }
}

class Course {
  final String title, description, iconSrc;
  final Color bgcolor;
  Course(
      {required this.title,
      this.description = "Build and animate an IOS app",
      this.iconSrc = "assets/img/logo_nrru.png",
      this.bgcolor = const Color(0xFF80A4FF)});
}

List<Course> courses = [
  Course(title: "Animation in SwifUI"),
  Course(
      title: "animation in flutter",
      iconSrc: "assets/img/logo_nrru.png",
      bgcolor: const Color(0xFF80A4FF))
];

List<Course> recentCourse = [
  Course(title: "State Machine"),
  Course(
      title: "Animatied Menu",
      iconSrc: "assets/img/logo_nrru.png",
      bgcolor: const Color(0xFF80A4FF)),
  Course(title: "Flutter with Rive"),
  Course(
      title: "Animatied Menu",
      iconSrc: "assets/img/logo_nrru.png",
      bgcolor: const Color(0xFF80A4FF))
];
