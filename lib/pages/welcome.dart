import 'package:app_muevete/models/option.dart';
import 'package:app_muevete/pages/home.dart';
import 'package:app_muevete/pages/welcome/page_one.dart';
import 'package:app_muevete/services/question_service.dart';
import 'package:app_muevete/services/questionary_service.dart';
import 'package:app_muevete/utils/tema.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final page_controller = PageController();
  final questions = QuestionService().getAllQuestions();
  final _questionaryService = QuestionaryService();
  bool finished = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    page_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: PageView(
              onPageChanged: (index) => {
                    setState(
                        () => {this.finished = index == (questions.length - 1)})
                  },
              physics: const NeverScrollableScrollPhysics(),
              controller: page_controller,
              children: _body()),
        ),
        bottomSheet: finished ? _finishButton() : _bootomSheet(),
      ),
    );
  }

  List<Widget> _body() {
    return questions
        .map((e) => PageOne(
              question: e,
              questionsLength: this.questions.length,
            ))
        .toList();
  }

  Widget _bootomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            child: Icon(
              Icons.arrow_back,
              color: Tema().getColorPrimary(),
            ),
            onPressed: () => page_controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: page_controller,
              count: questions.length,
              effect: ScrollingDotsEffect(
                dotWidth: 10,
                dotHeight: 10,
                dotColor: Colors.grey,
                activeDotColor: Tema().getColorPrimary(),
              ),
            ),
          ),
          TextButton(
            child: Text("SIGUIENTE",
                style: TextStyle(color: Tema().getColorPrimary())),
            onPressed: () => page_controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    );
  }

  Widget _finishButton() {
    return TextButton(
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          backgroundColor: Tema().getColorPrimary(),
          minimumSize: const Size.fromHeight(80)),
      onPressed: () async {
        _questionaryService.submitResponses(questions);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      },
      child: Text(
        "Finalizar",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  bool checkIfIsEmpty(List<Option> option) {
    bool isEmpty = true;
    option.forEach((e) {
      if (e.selected) {
        isEmpty = false;
      }
    });
    return isEmpty;
  }
}
