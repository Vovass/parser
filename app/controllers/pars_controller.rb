class ParsController < ApplicationController
  @@asd = ""
  @@arr = []
  $arr_urls = ["one","two","three"]

  def index
    @sometext = "Введите категорию онлайнера (то, что черным цветом): https://catalog.onliner.by/"
    @sometext2 = "headphones"
    @kat = @@asd
    @arr = @@arr
    @product = Product.joins(:category).select("products.name as pname, categories.name as cname").where("categories.name = ?", @@asd)
    
  end

  def sub
    @@asd = params[:linka]
    redirect_to "/"
    # @par = Par.new
    # @@arr = @par.getUrls(@@asd)#"https://catalog.onliner.by/" + @@asd.to_s
    # #pry
    # @@arr.each do |elem|
    #   Link.create(linkname: elem["name"])
    # end
  end


  # def show
  #   @pars = params[:katlink]
  # end

  # def new
  #   #@pars = Pars.new
  # end
  def onepage
    #render plain: params[:katlink]
  end

  # private def pars_params
  #   params.require(:katlink).permit(:linka)
  # end
end
