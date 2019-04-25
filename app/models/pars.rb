class Pars 
  def getjsoncontent(category, number, category_id)
  	page = Curl.get("https://catalog.api.onliner.by/search/#{category}?group=1&page=#{number}")
  	json = JSON.parse(page.body_str)
    arr_json = []

  	json["products"].each do |elem|
  		arr_json << {
  			"prod_id" => elem["id"],
  			"name" => elem["full_name"],
  			"description" => elem["description"],
  			"price_min" => elem["prices"] == nil ? 0 : elem["prices"]["min"],
  			"price_max" => elem["prices"] == nil ? 0 : elem["prices"]["max"],
  			"html_url" => elem["html_url"],
  			"img_url" => elem["images"]["header"] == nil ? 0 : elem["images"]["header"].gsub("//",""),
        "category_id" => category_id
  		}
  		elem["children"].each do |elem2|
  			arr_json << {
  				"prod_id" => elem2["id"],
  				"name" => elem2["full_name"],
  				"description" => elem2["description"],
          "price_min" => elem2["prices"] == nil ? 0 : elem2["prices"]["min"],
    			"price_max" => elem2["prices"] == nil ? 0 : elem2["prices"]["max"],
          "html_url" => elem2["html_url"],
  				"img_url" => elem2["images"]["header"] == nil ? 0 : elem2["images"]["header"].gsub("//",""),
          "category_id" => category_id
  			}
  		end
  	end
  	p "___________________________#{number}___________________________"
    arr_json
  end

  def getProducts(category)
    page = Curl.get("https://catalog.api.onliner.by/search/#{category.name}?group=1&page=1")
  	head = page.head.scan(/<https.+?>/)
    begin
  	   col_page = head[-1].scan(/page=.+?>/).join.scan(/\d/).join.to_i
    rescue
      col_page = 1
    end
    arr_json = []
    i = 1
    if col_page > 60
    	while i <= col_page do
    		sleep(i % 15 == 0 ? 7 : 0.5 )
    			arr_json << getjsoncontent(category.name, i, category.id)
    		i += 1
    	end
    else
    	while i <= col_page do
    			arr_json << getjsoncontent(category.name, i, category.id)
    		i += 1
    	end
    end
    arr_json.flatten
  end

  def getCategoryLoc()
    arr = []
    page = Curl.get("https://catalog.onliner.by")
    doc = Nokogiri::HTML(page.body_str)
    links = doc.xpath('//*[@class = "catalog-navigation-list__dropdown-list"]/a').each do |elem|
      full_link = elem.attribute('href').text
      name_links = full_link.gsub(/.+?\//, '') if !full_link.include?("?")

      cat_name = elem.search('span.catalog-navigation-list__dropdown-title').text.strip
      arr << name_links
      arr << cat_name
    end
    hash = Hash[*arr]
    hash.delete(nil)
    return hash
  end
end
