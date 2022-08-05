// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models.dart';

class MYList extends StatefulWidget {
  final Donations product;
  const MYList(this.product);

  @override
  State<MYList> createState() => _MYListState();
}

class _MYListState extends State<MYList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    maxRadius: 35,
                    backgroundImage: NetworkImage(
                       widget.product.image),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(widget.product.name , style: TextStyle(fontSize: 20),),
                    SizedBox(height: 10,),
                    Text('Hello' ,  style: TextStyle(fontSize: 15)) 
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

   Future<List<Donations>> fetchDonations(http.Client client) async {
    const String url =
        'https://edonations.000webhostapp.com/donor_pendingDonations.php';

    var data = {'user_id': 1};

    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    if (result.statusCode == 200) {
      final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
      var parse =
          parsed.map<Donations>((json) => Donations.fromJson(json)).toList();
      return parse;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
