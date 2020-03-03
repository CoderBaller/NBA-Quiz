import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getUrl(String name) async{
    final StorageReference ref = _storage.ref().child(name);
    var url = await ref.getDownloadURL();
    return url;
  }
}