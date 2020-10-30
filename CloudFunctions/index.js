const functions = require('firebase-functions');
const admin = require('firebase-admin');
var serviceAccount = require("C:\\Users\\hp\\Downloads\\serviceAccountDetails.json"); // Add path to services.json here
const { firebaseConfig } = require('firebase-functions');

admin.initializeApp({
credential: admin.credential.cert(serviceAccount),
databaseURL: "database url" // Add database url here
});
const db = admin.firestore();

// Function to check if user booked a product
exports.createBooking = functions.firestore
    .document('Bookings/{bookingId}')
    .onCreate(async(snap, context) => {

console.log(snap.id);
// TODO: Directly using the snap returned from function gives empty data, look for a solution

// Getting the booking details from Booking collection's newly created document
const bookingId = snap.id;
const bookingRef = db.collection('Bookings').doc(bookingId);
const booking = await bookingRef.get();

console.log(booking.data());

// Getting the seller's email from booking object
const sellerEmail = booking.data().sellerEmail;

// Getting the FCM token corresponding to the seller
const fcmTokenSnap = await db.collection('DeviceTokens').doc(sellerEmail).get();
const fcmToken = fcmTokenSnap.data().token;

// Creating the notification body
const payload = {
notification: {
title: `You have a new booking for your product "${booking.data().productName}"`,
body: `Please confirm new booking from ${booking.data.buyerEmail}`,
badge: '1',
sound: 'default'
}
}

// Sending the notification to seller
admin.messaging().sendToDevice(fcmToken, payload)
    .then(async(response) => {
console.log('Successfully sent message:', response)
})
    .catch(error => {
console.log('Error sending message:', error)
});

});

// Function to check if user confirmed a booking
exports.confirmBooking = functions.firestore
    .document('Bookings/{bookingId}')
    .onWrite(async(change, context) => {

// Fetching the old and new data
const oldData = change.before.data();
const newData = change.after.data();

if (oldData && newData) {
// Ensuring update is for booking confirmation
if (oldData.status == 'BookingStatus.PENDING' && newData.status == 'BookingStatus.CONFIRMED') {
console.log("Booking confirmed!");

// Updating the orders count of the seller
await db.collection('Sellers').doc(newData.sellerEmail).update({
orders: admin.firestore.FieldValue.increment(1)
});

// Decreasing the stock quantity of the product
await db.collection('Products').doc(newData.productId).update({
quantity: admin.firestore.FieldValue.increment(-(newData.quantity))
});

// Getting the FCM token corresponding to the user
const fcmTokenSnap = await db.collection('DeviceTokens').doc(newData.buyerEmail).get();
const fcmToken = fcmTokenSnap.data().token;

// Creating the notification body
const payload = {
notification: {
title: `Order confirmed`,
body: `Your booking for ${newData.productName} has been confirmed.`,
badge: '1',
sound: 'default'
}
}

// Sending the notification to user
admin.messaging().sendToDevice(fcmToken, payload)
    .then(async(response) => {
console.log('Successfully sent message:', response)
})
    .catch(error => {
console.log('Error sending message:', error)
});

}
}

});

// Function to cancel a booking
exports.cancelBooking = functions.firestore
    .document('Bookings/{bookingId}')
    .onDelete(async(snap, context) => {

// Getting the FCM token corresponding to the user
const fcmTokenSnap = await db.collection('DeviceTokens').doc(snap.data().buyerEmail).get();
const fcmToken = fcmTokenSnap.data().token;

// Creating the notification body
const payload = {
notification: {
title: `Booking cancelled`,
body: `Your booking for ${snap.data().productName} has been cancelled.`,
badge: '1',
sound: 'default'
}
}

// Sending the notification to user
admin.messaging().sendToDevice(fcmToken, payload)
    .then(async(response) => {
console.log('Successfully sent message:', response)
})
    .catch(error => {
console.log('Error sending message:', error)
});

});