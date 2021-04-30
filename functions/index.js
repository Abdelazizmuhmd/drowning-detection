const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
exports.alarmnotifiction = functions.firestore
  .document('lifeguardnotifications/{alrm}')
  .onCreate((snapshot, context) => {
      console.log(snapshot.data().orgID+snapshot.data().role)
    return admin.messaging().sendToTopic(snapshot.data().orgID+snapshot.data().sentTO, {
      notification: {
        title: 'ALarm',
        body: snapshot.data().text,
        sound:'defualt',
        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
      },
    });
  });

exports.medicNotification = functions.firestore
  .document('lifeguardreports/{reports}')
  .onCreate((snapshot, context) => {
      console.log(snapshot.data().orgID+snapshot.data().role)
    return admin.messaging().sendToTopic(snapshot.data().orgID+snapshot.data().sentTO, {
      notification: {
        title: snapshot.data().type,
        body: snapshot.data().comment,
        sound:'defualt',
        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
      },
    });
  });

  exports.orgNotification = functions.firestore
  .document('medicreports/{report}')
  .onCreate((snapshot, context) => {
      console.log(snapshot.data().orgID+snapshot.data().role)
    return admin.messaging().sendToTopic(snapshot.data().orgID+snapshot.data().sentTO, {
      notification: {
        title: snapshot.data().dae,
        body: snapshot.data().comment,
        sound:'defualt',
        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
      },
    });
  });