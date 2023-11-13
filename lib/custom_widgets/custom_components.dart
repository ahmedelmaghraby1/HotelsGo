// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotelsgo/business_logi/cubit/app_cubit.dart';
import 'package:hotelsgo/custom_widgets/custom_components_2.dart';

class Trapezium extends CustomPainter {
  final Color color;
  final double ratio;
  Trapezium({
    required this.color,
    required this.ratio,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * ratio, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomTrapezium extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  const CustomTrapezium({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.025,
        top: MediaQuery.of(context).size.width * 0.9,
        bottom: MediaQuery.of(context).size.height * 0.008,
      ),
      child: Stack(
        children: [
          SizedBox(
            width: width * 1.01,
            height: height,
            child: CustomPaint(
              painter: Trapezium(color: Colors.white, ratio: 0.7),
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: CustomPaint(
              painter: Trapezium(
                  color: const Color.fromARGB(255, 0, 83, 146), ratio: 0.695),
            ),
          ),
          Positioned(
            top: height * 0.25,
            left: width * 0.05,
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomDropdownFormField extends StatelessWidget {
  final List<String> options;
  String _selectdValue = "";
  CustomDropdownFormField({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DropdownButtonFormField<String>(
          alignment: Alignment.center,
          icon: const Icon(
            Icons.expand_more,
            size: 30,
          ),
          style: const TextStyle(
              fontSize: 18, color: Color.fromARGB(255, 9, 80, 138)),
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
          ),
          value: _selectdValue == "" ? options[0] : _selectdValue,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            _selectdValue = value ?? _selectdValue;
          }),
    );
  }
}

// ignore: must_be_immutable

class ModalListTile extends StatelessWidget {
  const ModalListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.02,
        ),
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return ListTile(
              contentPadding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01),
              title: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.025),
                child: Text(
                    "${AppCubit.get(context).rooms} rooms ,${AppCubit.get(context).adults} adults ,${AppCubit.get(context).children} children "),
              ),
              trailing: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: const Icon(
                  Icons.expand_more,
                  size: 30,
                ),
              ),
            );
          },
        ));
  }
}

class ShowModalBottomSheetButton extends StatelessWidget {
  const ShowModalBottomSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return InkWell(
            onTap: () {
              showBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return const ModalBottomSheetBody();
                  });
            },
            child: const ModalListTile());
      },
    );
  }
}

class FindHotelsButon extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  FindHotelsButon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(_textEditingController.text);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("find Hotels",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 50,
            ),
          )
        ],
      ),
    );
  }
}

class MainFormContainer extends StatelessWidget {
  final Widget child;
  const MainFormContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 252, 132, 52),
            borderRadius: BorderRadius.circular(15)),
        height: MediaQuery.of(context).size.height * 0.455,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.008,
          left: MediaQuery.of(context).size.width * 0.025,
          right: MediaQuery.of(context).size.width * 0.025,
        ),
        child: child);
  }
}

class SubMainFormContainer extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  SubMainFormContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.03),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
        height: MediaQuery.of(context).size.height * 0.38,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 11, 77, 131),
              Color.fromARGB(255, 3, 171, 255),
            ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.005,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                  style: const TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 6, 78, 136)),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Select city",
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 33, 150, 243)),
                    contentPadding: const EdgeInsets.all(5),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )),
            ),
            BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if (state is ChooseDateRangeState) {
                  _textEditingController.text =
                      AppCubit.get(context).dateRangeText;
                }
              },
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01,
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.008,
                  ),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                      keyboardType: TextInputType.none,
                      controller: _textEditingController,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color.fromARGB(255, 6, 78, 136)),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Select Date",
                        suffixIcon: InkWell(
                            child: Icon(
                                AppCubit.get(context).dateRangeIcon == false
                                    ? Icons.calendar_month
                                    : Icons.close),
                            onTap: () async {
                              AppCubit.get(context).selectDateRange(context);
                            }),
                        contentPadding: const EdgeInsets.all(5),
                        disabledBorder: const OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 2, 52, 93))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 2, 52, 93))),
                        enabledBorder: const OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 2, 52, 93))),
                        border: const OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(10),
                            ),
                      )),
                );
              },
            ),
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                      horizontal: MediaQuery.of(context).size.width * 0.02,
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.005,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: CustomDropdownFormField(
                      options: const [
                        "Select Nationality",
                        "Egypt",
                        "Palestine",
                        "KSA"
                      ],
                    ));
              },
            ),
            const ShowModalBottomSheetButton()
          ],
        ),
      ),
      FindHotelsButon()
    ]);
  }
}

class HomeScreenContainer extends StatelessWidget {
  const HomeScreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomTrapezium(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.5,
          text: "Hotels Search",
        ),
        MainFormContainer(child: SubMainFormContainer())
      ]),
    );
  }
}
