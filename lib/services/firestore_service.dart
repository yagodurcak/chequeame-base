import 'package:chequeamefirestore2/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');

  static FirestoreService instance;

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }

  Future incQuery(String uid) async {
    return await _usersCollectionReference
        .document(uid)
        .setData({"fullName": "javier"});
  }
}
//incQuery() {
//    queries +=1;
//  }
