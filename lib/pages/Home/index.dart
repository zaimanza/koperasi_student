import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_parcel/components/SideDrawer.dart';
import 'package:student_parcel/pages/Home/context/HomeProvider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    ref.read(homeProvider).getAllParcelByStudent(false);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> listItem = ref.watch(homeProvider).list;
    print("listItem");
    print(listItem);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Parcel Dash',
        ),
        centerTitle: false,
      ),
      drawer: SideDrawer(),
      body: ListView.builder(
        itemCount: listItem.length,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: Text(listItem[index]["parcelId"]),
                  subtitle: Text(
                    listItem[index]["courier"],
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    listItem[index]["remarks"] ?? "",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(homeProvider).getAllParcelByStudent(false);
        },
        child: Icon(Icons.autorenew_sharp),
      ),
    );
  }
}
