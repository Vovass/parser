class Par < ApplicationRecord
  #$arr_json = []
  def getjsoncontent(category, number)
  	page = Curl.get("https://catalog.api.onliner.by/search/#{category}?group=1&page=#{number}")
  	json = JSON.parse(page.body_str)
    arr_json = []

  	json["products"].each do |elem|
  		arr_json << {
  			"id" => elem["id"],
  			"name" => elem["full_name"],
  			"description" => elem["description"],
  			"price" => {
  									"min" => elem["prices"] == nil ? 0 : elem["prices"]["min"],
  									"max" => elem["prices"] == nil ? 0 : elem["prices"]["max"]},
  			"html_url" => elem["html_url"],
  			"img_url" => elem["images"]["header"]
  		}

  		elem["children"].each do |elem2|
  			arr_json << {
  				"id" => elem2["id"],
  				"name" => elem2["full_name"],
  				"description" => elem2["description"],
  				"price" => {
  										"min" => elem2["prices"] == nil ? 0 : elem2["prices"]["min"],
  										"max" => elem2["prices"] == nil ? 0 : elem2["prices"]["max"]},
  				"html_url" => elem2["html_url"],
  				"img_url" => elem2["images"]["header"].gsub("//","")
  			}
  		end
  	end
  	p "___________________________#{number}___________________________"
    return arr_json
  end

  def getUrls(category)
    page = Curl.get("https://catalog.api.onliner.by/search/#{category}?group=1&page=1")
  	head = page.head.scan(/<https.+?>/)
  	col_page = head[-1].scan(/page=.+?>/).join.scan(/\d/).join.to_i
    arr_json = []

    i = 1
    if col_page > 60
    	while i <= col_page do
    		sleep(i % 15 == 0 ? 7 : 0.5 )
    			arr_json << getjsoncontent(category, i)
    		i += 1
    	end
    else
    	while i <= col_page do
    			arr_json << getjsoncontent(category, i)
    		i += 1
    	end
    end
    arr_json.flatten
  end

end
