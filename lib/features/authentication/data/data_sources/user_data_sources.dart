import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import '../models/user_model.dart';

const connectionURL =
    "mongodb+srv://UhlLink:UhlLinkPassword@usersdatabase.zju3w.mongodb.net/UhlDB?retryWrites=true&w=majority";

Future<void> main() async {
  var data;
  var d = UhlUsersDB();

  try {
    await UhlUsersDB.connect();
    // data = await UhlUsersDB.getUserByEmail("gk.kush2005@gmail.com");
    data = await d.updatePassword("677307a0c3c87127fb411a89", "012345");
    print(data.toString());
    // if (data != null && data.isNotEmpty) {
    //   var firstUser = data[0]['_id'] as ObjectId;
    //   print('First User: ${firstUser.oid.toString()}'); // Debugging the first document
    // } else {
    //   print('No data found.');
    // }
  } catch (e) {
    print('Error: $e');
  }
}

class UhlUsersDB {
  static Db? db;
  static DbCollection? collection;

  UhlUsersDB();

  static Future<void> connect() async {
    db = await Db.create(connectionURL);
    await db?.open();
    inspect(db);
    collection = db?.collection('Users');
  }

  // Get All Data
  Future<List<Object>?> getData() async {
    try {
      final users = await collection?.find().toList();
      return users;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Get All Users Method
  Future<List<User>?> getUsers() async {
    try {
      final users = await collection?.find().toList();
      return users?.map((user) => User.fromJson(user)).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Update
  Future<bool?> updatePassword(String id, String password) async {
    try {
      // print(id);
      ObjectId objId = ObjectId.fromHexString(id);
      final success = await collection?.updateOne(
          where.eq('_id', objId), ModifierBuilder()..set('password', password));
      return success?.isSuccess;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool?> updateImage(String id, String image) async {
    try {
      // print(id);
      ObjectId objId = ObjectId.fromHexString(id);
      final success = await collection?.updateOne(
          where.eq('_id', objId), ModifierBuilder()..set('image', image));
      return success?.isSuccess;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Get By XYZ Methods
  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    try {
      final users = await collection
          ?.find(where.eq('email', email).eq('password', password))
          .toList();
      if (users?.length != 1) {
        return null;
      } else {
        return User.fromJson(users!.first);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<User>> getUserByEmail(String email) async {
    try {
      final users = await collection?.find(where.eq('email', email)).toList();
      if (users!.isNotEmpty) {
        return users.map((user) => User.fromJson(user)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<User>> getUserById(String id) async {
    try {
      ObjectId objId = ObjectId.fromHexString(id);
      final users = await collection?.find(where.eq('_id', objId)).toList();
      if (users!.isNotEmpty) {
        return users.map((user) => User.fromJson(user)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Close Connection
  Future<void> close() async {
    await db?.close();
    print('Connection to MongoDB closed');
  }
}
