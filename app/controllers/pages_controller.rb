class PagesController < ApplicationController
  @@textfild = ""
  def update
    @cat_textfild = @@textfild
  end

  def update_category
    @@textfild = params[:category]
    redirect_to "/update"

    if Category.exists?(name: @@textfild)
      last = Category.where(name: @@textfild).last
    else
      Category.create(name: @@textfild)
      last = Category.last
    end

    par = Par.new
    Product.transaction do
      parsed_data = par.getUrls(@@textfild, last.id)
      columns = ["name", "description", "price_min", "price_max", "html_url", "img_url", "category_id"]
      Product.import columns, parsed_data, validate:false
    end
  end
end
