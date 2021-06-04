import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';





admin.initializeApp();
exports.alarmnotifiction = functions.firestore
  .document('lifeguardnotifications/{alarm}')
  .onCreate((snapshot, context) => {
      console.log(snapshot.data().orgID+snapshot.data().role)
    return admin.messaging().sendToTopic(snapshot.data().orgID+snapshot.data().sentTO, {
      notification: {
        title: 'Alarm',
        body: snapshot.data().text,
        "sound": "alarm.mp3",
        
      
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
        "sound": "alarm.mp3",
        
        
      },
    });
  });

  exports.orgNotification = functions.firestore
  .document('medicreports/{report}')
  .onCreate((snapshot, context) => {
      console.log(snapshot.data().orgID+snapshot.data().sentTO)
    return admin.messaging().sendToTopic(snapshot.data().orgID+snapshot.data().sentTO, {
      notification: {
        title: 'Report',
        body: snapshot.data().comment,
        sound:'defualt',
        
      },
    });
  });


