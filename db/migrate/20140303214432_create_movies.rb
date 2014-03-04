class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :critics_score
      t.integer :positive_count
      t.integer :neutral_count
      t.integer :negative_count
      t.string :rating
      t.integer :runtime
      t.string :thumbnail_img
      t.string :profile_img

      t.timestamps
    end
  end
end
