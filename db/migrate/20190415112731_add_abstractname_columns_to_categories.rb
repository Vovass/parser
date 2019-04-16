class AddAbstractnameColumnsToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :abstract_name, :string
  end
end
