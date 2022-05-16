import 'package:flutter/material.dart';
import 'package:navigation_app/model/offices.dart';

class GoogleOffices extends StatefulWidget {
  @override
  _GoogleOfficesState createState() => _GoogleOfficesState();
}

class _GoogleOfficesState extends State<GoogleOffices> {
  late Future<OfficesList> officesList;

  @override
  void initState() {
    super.initState();
    // Call API
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google offices'),
        centerTitle: true,
      ),
      body: FutureBuilder<OfficesList>(
        future: officesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Has data from API
            return ListView.builder(
              itemCount: snapshot.data?.offices.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('${snapshot.data?.offices[index].name}'),
                    subtitle: Text('${snapshot.data?.offices[index].address}'),
                    leading:
                        Image.network('${snapshot.data?.offices[index].image}'),
                    isThreeLine: true,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            // Some error is happened
            return Text('${snapshot.error}');
          }
          // Wait for data from API
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
