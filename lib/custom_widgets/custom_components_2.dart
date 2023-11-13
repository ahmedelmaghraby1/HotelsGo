import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelsgo/business_logi/cubit/app_cubit.dart';

class CustomIncreamentOrDiscreamentWidget extends StatelessWidget {
  // type==?
  // 0 Rooms
  // 1 Adults
  // 2 Children
  final int type;
  final IconData icon;
  const CustomIncreamentOrDiscreamentWidget({
    Key? key,
    required this.type,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppCubit.get(context).addOrRemove(type, icon);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(25), left: Radius.circular(25)),
          border: Border.all(
              color: AppCubit.get(context).color(type, icon, context)),
        ),
        child:
            Icon(icon, color: AppCubit.get(context).color(type, icon, context)),
      ),
    );
  }
}

class CustomIncreamentRow extends StatelessWidget {
  final String title;
  final int type;
  const CustomIncreamentRow({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.008),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.2),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: CustomIncreamentOrDiscreamentWidget(
                        type: type,
                        icon: Icons.remove,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                          child: Text(
                        "${type == 0 ? AppCubit.get(context).rooms : type == 1 ? AppCubit.get(context).adults : AppCubit.get(context).children}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                    ),
                    Expanded(
                      flex: 1,
                      child: CustomIncreamentOrDiscreamentWidget(
                          type: type, icon: Icons.add),
                    ),
                  ])),
            ],
          ),
        );
      },
    );
  }
}

class RoomComponent extends StatelessWidget {
  final String title;
  const RoomComponent({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.015,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.width * 0.005),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: const CustomIncreamentRow(
                type: 1,
                title: "Adults",
              ),
            ),
            const CustomIncreamentRow(
              type: 2,
              title: "Children",
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppCubit.get(context).children,
                itemBuilder: (context, index) {
                  return ChildAge(index: index + 1);
                })
          ],
        ));
  }
}

class ChildAge extends StatelessWidget {
  final int index;
  const ChildAge({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Text("Age of child $index", style: const TextStyle(fontSize: 18)),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width * 0.16,
        child: TextFormField(
            cursorRadius: Radius.zero,
            cursorColor: Colors.transparent,
            decoration: const InputDecoration(
                hintText: "14 years",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none)),
      ),
    );
  }
}

class PetSwitch extends StatelessWidget {
  PetSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: SwitchListTile(
              activeTrackColor: Colors.grey,
              activeColor: Colors.green,
              inactiveTrackColor: Colors.grey,
              value: AppCubit.get(context).pets,
              onChanged: (value) {
                AppCubit.get(context).allowPets(value);
              },
              title: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Pet-friendly ",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: 20,
                  )
                ],
              ),
              subtitle: const Text(
                "Only show stays that allow pets ",
              )),
        );
      },
    );
  }
}

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 8, 100, 175),
      ),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06,
          vertical: MediaQuery.of(context).size.width * 0.04),
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          "Apply",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: SizedBox(
        child: AppBar(
          leading: null,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: Colors.white,
          title: const Text("Rooms and Guests"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  AppCubit.get(context).reset(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}

class ModalBottomSheetBody extends StatelessWidget {
  const ModalBottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(222, 222, 222, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppbar()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  return Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06,
                        right: MediaQuery.of(context).size.width * 0.06,
                        top: MediaQuery.of(context).size.height * 0.03,
                        bottom: MediaQuery.of(context).size.height * 0.015,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                        vertical: MediaQuery.of(context).size.height * 0.015,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const CustomIncreamentRow(
                        type: 0,
                        title: "Rooms",
                      ));
                },
              ),
              BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: AppCubit.get(context).rooms,
                      itemBuilder: (context, index) {
                        return RoomComponent(
                            title: "ROOM ${AppCubit.get(context).rooms}");
                      });
                },
              ),
              PetSwitch(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const ApplyButton()
            ],
          ),
        ),
      ),
    );
  }
}
