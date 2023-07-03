class CreatePostCategoryFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :post_category_features do |t|
      t.integer :post_id
      t.integer :category_feature_id
      t.timestamps
    end
  end
end
