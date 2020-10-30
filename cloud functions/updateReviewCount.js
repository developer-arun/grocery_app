const functions=require('firebase-functions');
const db=functions.firestore;
/*updates value of review count when documnet is created
at (/Reviews&Ratings/{ReviewDoc}) location*/
exports.updateReviewCount=db.document('/Reviews&Ratings/{ReviewDoc}')
    .onCreate((snapshot,context)=>{
        const ReviewDoc=context.params.ReviewDoc;
        //getting product id
        const productID=ReviewDoc.productId;
        console.log(`New Product \n${ReviewDoc}\n${productID}\n`);
        //finding document in ("Product") collection
        const docRef=db.collection("Products").doc(productID);
        docRef.get().then((doc)=>{
            if(doc.exists){
                // incrementing value of doc
                const count=doc.data()['reviews']++;
                docRef.update({
                    reviews:count
                });
                const rating=doc.data()['ratings'];

            }
            else{
                return null;
            }
    });
});
