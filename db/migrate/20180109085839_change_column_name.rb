class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :article_categories, :categories_id, :category_id 
  end
end
