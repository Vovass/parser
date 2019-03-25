class Par < ApplicationRecord

  $arr_urls = []

  def getUrls(cat)
    #html = Curl.get(cat)
    html = Watir::Browser.new :chrome, headless:true
    html.goto cat

  	doc = Nokogiri::HTML(html.html)
    i = 0
  	doc.xpath('//div[@class = "schema-product__title"]/a/span').each do |elem|

  		$arr_urls << "#{i += 1}: " + elem.text
  	end
  end

end
