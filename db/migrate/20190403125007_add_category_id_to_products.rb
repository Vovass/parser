class AddCategoryIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :products, :category
  end
end
