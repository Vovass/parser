class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price_min
      t.decimal :price_max
      t.string :html_url
      t.string :img_url
    end
  end
end
