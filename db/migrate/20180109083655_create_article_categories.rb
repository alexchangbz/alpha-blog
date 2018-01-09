class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.integer :article_id
      t.integer :categories_id
    end
  end
end
