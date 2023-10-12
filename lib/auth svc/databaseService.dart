import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class databaseService {
  final String? uid;
  databaseService({this.uid});

//reference for collections

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set(
        {"fullName": fullName, "email": email, "uid": uid, "userType": "user"});
  }

  final CollectionReference workerCollection =
      FirebaseFirestore.instance.collection("workers");
  Future savingworkerData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "uid": uid,
      "userType": "worker"
    });
  }

//getting user data

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
//create service request

  void createServiceRequest(
      String issue, String userId, bool AcceptStatus, String SenderId) {
    FirebaseFirestore.instance.collection('service_requests').add({
      'issue': issue,
      'userId': userId,
      'createdAt': DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
      'AcceptStatus': AcceptStatus,
      'SenderId': SenderId
    });
  }

  //save worker listing
  CollectionReference workersRef =
      FirebaseFirestore.instance.collection('workerlisting');
  // function to save the listing data to Firestore
  Future<void> saveworkerlisting(String? DisplayName, String title,
      String workerid, String? category, String Description) async {
    // new document with a unique ID in the 'drivers' collection
    DocumentReference newworkersRef = workersRef.doc();

    await newworkersRef.set({
      'DisplayName': DisplayName,
      'title': title,
      'worker id': workerid,
      'category': category,
      'Description': Description
    });
  }

  //user collection ref
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  //add imageurl field in user
  Future SavingImageurl(String ImageUrl) async {
    return await userCollection.doc(uid).set({
      "ImageUrl": ImageUrl,
    });
  }
}
