import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/controller/my_firebase_helper.dart';
import 'package:flutter_first/globale.dart';
import 'package:flutter_first/model/my_user.dart';

class MyAllUsers extends StatefulWidget {
  const MyAllUsers({super.key});

  @override
  State<MyAllUsers> createState() => _MyAllUsersState();
}

class _MyAllUsersState extends State<MyAllUsers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: MyFirebaseHelper().cloudUsers.snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            //temps d'attente lors de la connexion à la base de donnée
            return const CircularProgressIndicator.adaptive();
          } else {
            if (!snap.hasData) {
              //il n'y a pas d'informations dans la base de donnée
              return const Center(
                child: Text("Aucune donnée"),
              );
            } else {
              List documents = snap.data!.docs;
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    MyUser lesAutres = MyUser(documents[index]);
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(lesAutres.image!),
                        ),
                        title: Text(lesAutres.nom),
                        subtitle: Text(lesAutres.mail),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            
                            setState(() {
                              if (moi.favoris!.contains(lesAutres)) {
                                moi.favoris!.remove(lesAutres);
                              } else {
                                moi.favoris!.add(lesAutres);
                              }
                            });
                            Map<String, dynamic> data = {
                                  "FAVORIS": moi.favoris
                                };
                            MyFirebaseHelper().updateUser(moi.uid, data);
                          },
                        ),
                      ),
                    );
                  });
            }
          }
        });
  }
}
