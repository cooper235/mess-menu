import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:uhl_link/features/home/data/models/job_model.dart';

const connectionURL =
    "mongodb+srv://UhlLink:UhlLinkPassword@usersdatabase.zju3w.mongodb.net/UhlDB?retryWrites=true&w=majority";

Future<void> main() async {
  var d = JobPortalDB();

  try {
    await JobPortalDB.connect();
    // data = await UhlUsersDB.getUserByEmail("gk.kush2005@gmail.com");
    // if (data != null && data.isNotEmpty) {
    //   var firstUser = data[0]['_id'] as ObjectId;
    //   print('First User: ${firstUser.oid.toString()}'); // Debugging the first document
    // } else {
    print('No data found.');
    // }
  } catch (e) {
    print('Error: $e');
  }
}

class JobPortalDB {
  static Db? db;
  static DbCollection? collection;

  JobPortalDB();

  static Future<void> connect() async {
    db = await Db.create(connectionURL);
    await db?.open();
    inspect(db);
    collection = db?.collection('Job Portal');
  }

  // Get All Data Method
  Future<List<Job>> getJobs() async {
    try {
      final jobs = await collection?.find().toList();
      if (jobs != null) {
        return jobs.map((job) => Job.fromJson(job)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  // Close Connection
  Future<void> close() async {
    await db?.close();
    print('Connection to MongoDB closed');
  }
}
