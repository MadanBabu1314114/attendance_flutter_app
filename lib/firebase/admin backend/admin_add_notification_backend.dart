import '../../data/data.dart';
import 'admin_add_branch_backend.dart';

Future<bool> addNotificationOfAdmin(String title, String desc) async {
  final datetime = DateTime.now();
  final notificationDatabase = database
      .child("notification/${datetime.day}-${datetime.month}-${datetime.year}");

  await notificationDatabase.set({
    "date": "${datetime.day}-${datetime.month}-${datetime.year}",
    "title": title,
    "note": desc
  });
  return true;
}

// Future<List<NotificationAdmin>> retrieveNotifationForStudent() async {
//   String title = "";
//   String date = "";
//   String desc = "";
//   final notificationDatabase = database.child("notification");
//   List<NotificationAdmin> listNotifications = [];
  
//   await notificationDatabase.once().then((value) {
//     final notifationDetailSnapShot = value.snapshot.value as Map;
//     notifationDetailSnapShot.forEach((key, value) {
//       listNotifications
//           .add(NotificationAdmin(value['title'], value['date'], value['note']));
//     });
//   });

//   return listNotifications;
// }


Future<List<NotificationAdmin>> retrieveNotificationForStudent() async {
  final notificationDatabase = database.child("notification");
  List<NotificationAdmin> listNotifications = [];

  try {
    final snapshot = await notificationDatabase.once();

    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> notificationData = snapshot.snapshot.value as Map;
      notificationData.forEach((key, value) {
        if (value != null && value is Map) {
          String title = value['title'] ?? "";
          String date = value['date'] ?? "";
          String note = value['note'] ?? "";
          listNotifications.add(NotificationAdmin(title, date, note));
        }
      });
    }
  } catch (e) {
    print("Error retrieving notifications: $e");
    // Handle the error appropriately, e.g., log it or throw an exception
  }

  return listNotifications;
}
