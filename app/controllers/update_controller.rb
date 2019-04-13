class UpdateController < ApplicationController
  @@textfild = ""
  @@error = ""
  @@wait = ""
  def update
    @cat_textfild = @@textfild
    @error = @@error
    @category = Category.select("name").where("categories.name = ?", @@textfild)
    @wait = @@wait
  end

  def update_category #
    @@textfild = params[:category]
    @@wait = "Please wait..."
    redirect_to "/"
    saveData(getCategoryByName(@@textfild))
  end

  def getCategoryByName(name)
    return Category.where(name: name).last if Category.exists?(name: name)
    Category.create(name: name)
    return Category.last
  end

  def saveData(category)
    parser = Pars.new
    begin
      Product.transaction do
        parsed_data = parser.getProducts(category)
        columns = ["name", "description", "price_min", "price_max", "html_url", "img_url", "category_id"]
        Product.import columns, parsed_data, validate:false
      end
    rescue NoMethodError
      @@error = "Такой категории не существует"
      Category.delete(category)
    end
  end

end
