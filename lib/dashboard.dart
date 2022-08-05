// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:demo_app/my_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pandabar/pandabar.dart';
import 'package:neos_bottom_navigation/neos_bottom_navigation.dart';

import 'models.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String page = 'Grey';
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('https://avatars.mds.yandex.net/i?id=f4515bb14779f7534c43fd3dad0997a9-4885166-images-thumbs&n=13'),
              fit: BoxFit.cover),
            
        ),
        child: Column(
          children: [
              Stack(
          children: [
            // Container(
            //   alignment: Alignment.center,
            //   child: Image.network(
            //     '',
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  'Applicatuion Request',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.yellow),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 150, 0, 0),
              child: Container(
                alignment: Alignment.center,
                width: 350,
                height: 50,
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                  decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(color: Colors.yellow),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 25, 0),
                        child: Icon(
                          Icons.search,
                          color: Colors.yellow,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Colors.yellow),
                          gapPadding: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: Colors.yellow),
                        gapPadding: 10,
                      )),
                ),
              ),
            ),
        
          ],
        ),

            Expanded(
              child: Stack(
                children: [
                  Container(
                     margin: EdgeInsets.only(top: 28),
                    decoration: BoxDecoration(
                      
                        color: Colors.white,
                        
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)
                          // bottomLeft: Radius.circular(30),
                          // bottomRight: Radius.circular(30),
                        )),
                        

                      
                  ),
                  FutureBuilder(
                    future: fetchDonations(http.Client()),
                    builder: (context , AsyncSnapshot<List<Donations>> snapshot){
                      if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } 
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                     itemBuilder: (context , index){
                      return Container(

        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    maxRadius: 35,
                    backgroundImage: NetworkImage(
                       snapshot.data![index].image),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(snapshot.data![index].name, style: TextStyle(fontSize: 20),),
                    SizedBox(height: 10,),
                    Text('Hello' ,  style: TextStyle(fontSize: 15)) 
                  ],
                )
              ],
            )
          ],
        ),
      );
                     }
                     );
            
                  
                

                    }
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PandaBar(
         buttonData: [
          PandaBarButtonData(
            id: 'Grey',
            icon: Icons.dashboard,
            title: 'Grey'
          ),
         
        
          PandaBarButtonData(
            id: 'Yellow',
            icon: Icons.notifications,
            title: 'Yellow'
          ),
        ],
         onChange: (id) {
          setState(() {
            page = id;
          });
        },)
    );
  }

     Future<List<Donations>> fetchDonations(http.Client client) async {
    const String url =
        'https://edonations.000webhostapp.com/donor_pendingDonations.php';

    var data = {'user_id': 34};

    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    if (result.statusCode == 200) {
      final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
      var parse =
          parsed.map<Donations>((json) => Donations.fromJson(json)).toList();
          print(result.body);
      return parse;
      
    } else {
      throw Exception('Failed to load album');
    }
  }
}
