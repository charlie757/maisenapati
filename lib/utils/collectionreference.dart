import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference usersRef = firestore.collection('user_masters');
CollectionReference spreadCampagin = firestore.collection('spreadCampagin');
CollectionReference district = firestore.collection('district');
