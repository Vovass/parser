class MainController < ApplicationController

  def index
    @categorys = Category.all
    respond_to do |format|
      format.html
      format.csv {send_data(export_csv(@@selected_products), :filename => "#{@@cats_name}.csv", :type => 'text/csv;')}
    end
  end

  def query
    cats_name = params[:select_category]
    product = Product.new
    if Category.exists?(name: cats_name)
      selected_products = product.getByCategory(getCategoryByName(cats_name).id)
    end
    respond_to do |format|
      format.json {render json: selected_products}
      #format.csv {send_data(export_csv(selected_products), :filename => "#{cats_name}.csv", :type => 'text/csv;')}
    end
    @@selected_products = selected_products
    @@cats_name = cats_name
  end

  def getCategoryByName(name)
    return Category.where(name: name).last if Category.exists?(name: name)
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

end
