import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String firstname, String secondname, String phone, String address, String dateofbirth, String bloodgroup, String weigh, String height, String allergy, String chronicdisease) async {
    try {
      await firestore.collection("patients").add({
        'firstname': firstname,
        'secondname': secondname,
        'phone': phone,
        'address': address,
        'dateofbirth': dateofbirth,
        'bloodgroup': bloodgroup,
        'weigh': weigh,
        'height': height,
        'allergy':allergy,
        'chronicdisease': chronicdisease,

        'timestamp': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("patients").doc(id).delete();
    } catch (e) {
      print(e);

    }
  }
  dynamic read() async {
    QuerySnapshot querySnapshot;
    List docs = [];

    try {
      querySnapshot = await firestore.collection('patients').orderBy('timestamp').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "firstname": doc['firstname'], "secondname": doc["secondname"],"phone": doc['phone'],"address": doc['address'],"dateofbirth": doc['dateofbirth'],"bloodgroup": doc['bloodgroup'],"weigh": doc['weigh'],"height": doc['height'],"allergy": doc['allergy'],"chronicdisease": doc['chronicdisease']};
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);

    }
  }

  Future<void> update(String id, String firstname, String secondname, String phone, String address, String dateofbirth, String bloodgroup, String weigh, String height, String allergy, String chronicdisease) async {
    try {
      await firestore
          .collection("patients")
          .doc(id)
          .update({'firstname': firstname,
        'secondname': secondname,
        'phone': phone,
        'address': address,
        'dateofbirth': dateofbirth,
        'bloodgroup': bloodgroup,
        'weigh': weigh,
        'height': height,
        'allergy':allergy,
        'chronicdisease': chronicdisease,});
    } catch (e) {
      print(e);
    }
  }
}