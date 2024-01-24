// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// final FirebaseStorage _storage = FirebaseStorage.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// class StoreProfilePic {
//   Future<String> uploadImageToStorage(String childName, Uint8List file) async {
//     try {
//       Reference ref = _storage.ref().child(childName);
//       UploadTask uploadTask = ref.putData(file);
//       TaskSnapshot snapshot = await uploadTask;
//       String downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (error) {
//       print('Error uploading image to storage: $error');
//       throw error; // Propagate the error to the calling function
//     }
//   }

//   Future<String> saveImage({required Uint8List file}) async {
//     try {
//       String imageUrl = await uploadImageToStorage('profileImage', file);
//       await _firestore.collection('image').add({
//         'profilePic': imageUrl
//       }); // Use add() to automatically generate a document ID
//       return "Success";
//     } catch (error) {
//       print('Error saving image to Firestore: $error');
//       return "Some Error Occurred: $error"; // Return a more descriptive error message
//     }
//   }
// }
