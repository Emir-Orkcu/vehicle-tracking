// ignore_for_file: file_names
import 'package:CarTracker/constants/constants.dart';
import 'package:CarTracker/viewModel/send_view.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, String>>? questionAndAnswer = [];
  List<String> questions = [];
  List<String> quesstionIds=[];
  List<List<String>> answers = [];
  List<List<String>> answersIds=[];

  void getQuestions() async {
    await context.read<SendViewModel>().getQuestions(context);
    context.read<SendViewModel>().questionModel.data!.forEach((element) {
      questions.add(element.questions!);
      quesstionIds.add(element.id!);
      answers.add(element.answers!);
     });
  }

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SendViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1f2b51),
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Form(
              key: _formKey,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/arka-plan.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: currentStatus == ApiResponseStatus.loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Constants().padding * 2,
                                horizontal: Constants().padding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  for (int i = 0;
                                      i < provider.questionModel.data!.length;
                                      i++)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: Constants().padding,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            questions[i],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          customSelectBox(
                                              answers[i],
                                              "Cevap", (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Boş bırakılamaz";
                                            } else {
                                              return null;
                                            }
                                          },quesstionIds[i]),
                                        ],
                                      ),
                                    ),
                                  const SizedBox(height: 20),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          print(questionAndAnswer);
                                          provider.sendQuestion(
                                              context, questionAndAnswer);
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height: 54,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: const Color(0xff61aefe),
                                        ),
                                        child:  Center(
                                          child:currentStatus==ApiResponseStatus.loading ? const CircularProgressIndicator(color: Colors.white,): const Text(
                                            "Activate Car",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget customSelectBox(itemList, hintText, validation,questionId) {
    //var provider = Provider.of<SendViewModel>(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      child: CustomDropdown<String>(
        validator: validation,
        closedHeaderPadding:
            EdgeInsets.symmetric(horizontal: Constants().padding),
        hintText: hintText,
        items: itemList,
        initialItem: null,
        
        onChanged: (value) {
         questionAndAnswer!.add({
            "questionId":questionId,
            "answer":  value!,
          });
        },
      ),
    );
  }
}
