const functions = require('firebase-functions');
const admin=require('firebase-admin');
const db=admin.firestore();
const database=functions.firestore;
exports.updateRating=database.document('/Reviews&Ratings/{ReviewDoc}')
    .onCreate((snapshot,context)=>{
        //get review id
        const reviewID=snapshot.id;
        console.log(`New Product \n${reviewID}\n`);
        const reviewDoc=db.collection("Reviews&Ratings").doc(`${reviewID}`)
        .get().then((snapshot,context)=>{
            //getting newly added value of rating
            const rating=snapshot.rating;
            //getting product snapshot
            const product=db.collection('Products').doc(snapshot.productId)
            .get().then((snapshot,context)=>{
                //getting no. of reviews
                const review=snapshot.reviews;
                //calculating sum of all old rating of product
                const oldRating=snapshot.rating*review;
                //calulating new rating
                const newRating=(rating+oldRating)/(review+1);
                const product=db.collection('Products').doc(snapshot.productId)
                .update({
                    //updating new value of review count and rating
                    "rating" :newRating,
                    "reviews":review+1
            });
            const Updatedproduct=db.collection('Products').doc(snapshot.productId)
            .get().then((snapshot,context)=>{
                console.log(snapshot);
            });
        });
    });
});