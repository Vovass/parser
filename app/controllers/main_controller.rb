class MainController < ApplicationController

  def index
    @categorys = Category.all
    respond_to do |format|
      format.html
      format.csv {send_data(export_csv(@@selected_products), :filename => "#{@@cats_name}.csv", :type => 'text/csv;')}
    end
  end
#Сделать button update для обновления данных в существующей категории
  def query
    cats_name = params[:select_category]
    product = Product.new
    find_category = getCategoryByName(cats_name)

    selected_products = product.getProductsByCategoryId(find_category.id)
    if selected_products.blank?
      saveData(find_category)#проблема с одностраничниками
      selected_products = product.getProductsByCategoryId(find_category.id)
    end
    respond_to {|format| format.json {render json: selected_products}} #format.csv {send_data(export_csv(selected_products), :filename => "#{cats_name}.csv", :type => 'text/csv;')}
    @@selected_products = selected_products
    @@cats_name = cats_name
  end

  def getCategoryByName(name)
    Category.where(name: name).last if Category.exists?(name: name)
  end

  def export_csv(obj)# object database selected Products
    head = %w{product_name category_name description price_min price_max html_url img_url}
    CSV.generate(col_sep: ";") do |csv|
      csv << head
      obj.each do |elem|
        csv << head.map{|attr| elem.send(attr)}
      end
    end
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
    end
  end
    #addCategories(parser.getCategoryLoc())

    # def addCategoriesLocal(hash)
    #   hash.each do |key, value|
    #     Category.create(name: key, abstract_name: value) if !Category.exists?(name: key)
    #   end
    # end
end
