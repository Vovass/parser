class ParsController < ApplicationController
  @@asd = ""
  @@arr = []
  $arr_urls = ["one","two","three"]

  def index
    @sometext = "Введите категорию онлайнера (то, что черным цветом): https://catalog.onliner.by/"
    @sometext2 = "headphones"
    @kat = @@asd
    @arr = @@arr
    @links = Link.all
  end

  def sub
    @@asd = params[:linka]
    redirect_to "/"
    @par = Par.new()
    @@arr = @par.getUrls("https://catalog.onliner.by/" + @@asd)#"https://catalog.onliner.by/" + @@asd.to_s
    @@arr.each do |elem|
      Link.create(linkname: elem)
    end
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
