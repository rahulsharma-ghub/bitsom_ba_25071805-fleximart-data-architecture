// MongoDB Operations Assignment

// OPERATION 1: Load Data (already imported using MongoDB Compass)

// OPERATION 2: Find Electronics products with price less than 50000

db.products.find(
  { category: "Electronics", price: { $lt: 50000 } },
  { _id: 0, name: 1, price: 1, stock: 1 }
)

db.products.aggregate([
  {
    $addFields: {
      avgRating: { $avg: "$reviews.rating" }
    }
  },
  {
    $match: {
      avgRating: { $gte: 4.0 }
    }
  },
  {
    $project: {
      _id: 0,
      name: 1,
      avgRating: 1
    }
  }
]);

// OPERATION 4: Add a new review to product ELEC001

db.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user_id: "U999",
        username: "NewUser",
        rating: 4,
        comment: "Good value",
        date: new Date()
      }
    }
  }
);


// OPERATION 5: Calculate average price by category

db.products.aggregate([
  {
    $group: {
      _id: "$category",
      avg_price: { $avg: "$price" },
      product_count: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      category: "$_id",
      avg_price: 1,
      product_count: 1
    }
  },
  {
    $sort: { avg_price: -1 }
  }
]);
