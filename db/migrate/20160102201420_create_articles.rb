class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :headline
      t.text :content
      t.integer :comments
      t.datetime :published
      t.string :url
      t.integer :achievement

      t.timestamps null: false
    end
  end
end
