const functions = require('firebase-functions');
const admin = require('firebase-admin');
var serviceAccount = require("C:\\Users\\hp\\Downloads\\serviceAccountDetails.json");   // TODO: ADD PATH TO SERVICES.JSON HERE
const { firebaseConfig } = require('firebase-functions');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "<ADD DATABASE URL HERE>" // TODO: ADD DATABASE URL
});
const db = admin.firestore();


// Function to check if user booked a product
exports.createBooking = functions.firestore
    .document('Bookings/{bookingId}')
    .onCreate(async(snap, context) => {

        // TODO: Directly using the snap returned from function gives empty data, look for a solution

        // Getting the booking details from Booking collection's newly created document
        const bookingId = snap.id;
        const bookingRef = db.collection('Bookings').doc(bookingId);
        const booking = await bookingRef.get();

        // Getting the seller's email from booking object
        const sellerEmail = booking.data().sellerEmail;

        // Getting the FCM token corresponding to the seller
        const fcmTokenSnap = await db.collection('DeviceTokens').doc(sellerEmail).get();
        const fcmToken = fcmTokenSnap.data().token;

        // Creating the notification body
        const payload = {
            notification: {
                title: `You have a new booking for your product "${booking.data().productName}"`,
                body: `Please confirm new booking from ${booking.data().buyerEmail}`,
                badge: '1',
                sound: 'default',
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
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


// Function to check if user subscribed to a product
exports.createSubscription = functions.firestore
    .document('Subscriptions/{subscriptionId}')
    .onCreate(async(snap, context) => {

        // TODO: Directly using the snap returned from function gives empty data, look for a solution

        // Getting the subscription details from Subscriptions collection's newly created document
        const subscriptionId = snap.id;
        const subscriptionRef = db.collection('Subscriptions').doc(subscriptionId);
        const subscription = await subscriptionRef.get();

        // Getting the seller's email from subscription object
        const sellerEmail = subscription.data().sellerEmail;

        // Getting the FCM token corresponding to the seller
        const fcmTokenSnap = await db.collection('DeviceTokens').doc(sellerEmail).get();
        const fcmToken = fcmTokenSnap.data().token;

        // Creating the notification body
        const payload = {
            notification: {
                title: `You have a new subscription for your product "${subscription.data().productName}"`,
                body: `Please confirm new subscription from ${subscription.data().buyerEmail}`,
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

// Function to cancel a subscription
exports.cancelSubscription = functions.firestore
    .document('Subscriptions/{subscriptionId}')
    .onDelete(async(snap, context) => {

        // Getting the FCM token corresponding to the user
        const fcmTokenSnap = await db.collection('DeviceTokens').doc(snap.data().buyerEmail).get();
        const fcmToken = fcmTokenSnap.data().token;

        // Creating the notification body
        const payload = {
            notification: {
                title: `Subscription cancelled`,
                body: `Your subscription for ${snap.data().productName} has been cancelled by the store.`,
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

// Function to handle events after confirmation of a subscription
exports.confirmSubscription = functions.firestore
    .document('Subscriptions/{subscriptionId}')
    .onWrite(async(change, context) => {

        // Fetching the old and new data
        const oldData = change.before.data();
        const newData = change.after.data();

        if (oldData && newData) {
            // Ensuring update is for subscription confirmation
            if (oldData.status == 'BookingStatus.PENDING' && newData.status == 'BookingStatus.CONFIRMED') {
                console.log("Subscription confirmed!");

                // Notifying the user
                // Getting the FCM token corresponding to the user
                const fcmTokenSnap = await db.collection('DeviceTokens').doc(newData.buyerEmail).get();
                const fcmToken = fcmTokenSnap.data().token;

                // Creating the notification body
                const payload = {
                    notification: {
                        title: `Subscription confirmed`,
                        body: `Your subscription for ${newData.productName} has been confirmed.`,
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

                // TODO: ADD SCHEDULED FUNCTION
            }
        }

    });

// Called when a new review is added for a product
exports.addReview = functions.firestore
    .document('Reviews&Ratings/{docId}')
    .onCreate(async(snap, context) => {

        // Increasing the total number of reviews for the product
        console.log(snap.data());
        await db.collection('Products').doc(snap.data().productId).update({
            reviews: admin.firestore.FieldValue.increment(1)
        });

        // Updating the rating count for the product
        await db.collection('RatingCounts').doc(snap.data().productId).set({
            count: admin.firestore.FieldValue.increment(1)
        }, {
            merge: true
        });

        // Updating the rating sum for the product
        await db.collection('RatingCounts').doc(snap.data().productId).set({
            ratingSum: admin.firestore.FieldValue.increment(snap.data().rating)
        }, {
            merge: true
        });

        // Fetching the product rating
        const ratingCalc = await db.collection('RatingCounts').doc(snap.data().productId).get();
        const rating = ratingCalc.data().ratingSum / ratingCalc.data().count;

        // Updating the product rating
        await db.collection('Products').doc(snap.data().productId).set({
            rating: rating
        }, {
            merge: true
        });

    });

// Called when user changes his review
exports.changeReview = functions.firestore
    .document('Reviews&Ratings/{docId}')
    .onWrite(async(change, context) => {

        // Fetching the old and new data
        const oldData = change.before.data();
        const newData = change.after.data();

        // Ensure that the rating has been updated
        if (oldData && newData) {
            if (oldData.rating != newData.rating) {

                console.log(`Rating changed from ${oldData.rating} to ${newData.rating}`);

                // Removing the old rating
                await db.collection('RatingCounts').doc(newData.productId).set({
                    ratingSum: admin.firestore.FieldValue.increment(-oldData.rating)
                }, {
                    merge: true
                });

                // Setting the new rating
                await db.collection('RatingCounts').doc(newData.productId).set({
                    ratingSum: admin.firestore.FieldValue.increment(newData.rating)
                }, {
                    merge: true
                });

                // Fetching the product rating
                const ratingCalc = await db.collection('RatingCounts').doc(newData.productId).get();
                const rating = ratingCalc.data().ratingSum / ratingCalc.data().count;

                // Updating the product rating
                await db.collection('Products').doc(newData.productId).set({
                    rating: rating
                }, {
                    merge: true
                });
            }
        }

    });


exports.scheduledFunction = functions.pubsub.schedule('every 24 hours').onRun(async(context) => {

    // TODO: GENERATE BOOKING OBJECT FROM SUBSCRIPTIONS

});