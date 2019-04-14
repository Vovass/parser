class MainController < ApplicationController
  @@textfild = ""
  @@display_block = "none"

  def index
    @textfild_category = @@textfild

    @categorys = Category.all
    @product = Product.joins(:category).select("products.name as product_name, categories.name as category_name, description, price_min, price_max, html_url, img_url").where("categories.name = ?", @@textfild)
    @display_block = @@display_block

    respond_to do |format|
      format.html
      format.csv {send_data(export_csv(@product), :filename => "#{@textfild_category}.csv", :type => 'text/csv;')}
    end
  end

  def query
    cats_name = params[:select_category]
    @all = Product.joins(:category).select("products.name as product_name, categories.name as category_name, description, price_min, price_max, html_url, img_url").where("categories.name = ?", cats_name)
    respond_to do |format|
      format.json {render json: @all}
    end
  end

  def check#cheach
    @@display_block = "block"
    @@textfild = params[:linka]
    redirect_to "/"
  end

  def export_csv(obj)
    head = %w{product_name category_name description price_min price_max html_url img_url}
    CSV.generate(col_sep: ";") do |csv|
      csv << head
      obj.each do |elem|
        csv << head.map{|attr| elem.send(attr)}
      end
    end
  end

end
