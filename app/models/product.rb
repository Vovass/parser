class Product < ActiveRecord::Base
  belongs_to :category, class_name: 'Category', foreign_key: :category_id


  def getProductsByCategoryId(category_id)
    return Product.joins(:category)
    .select("products.name as product_name, categories.name as category_name, description, price_min, price_max, html_url, img_url")
    .where("products.category_id = ?", category_id)
  end
end
