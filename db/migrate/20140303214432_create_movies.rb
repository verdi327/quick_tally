class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :critics_score
      t.integer :positive_count, default: 0
      t.integer :neutral_count, default: 0
      t.integer :negative_count, default: 0
      t.string :rating
      t.integer :runtime
      t.string :thumbnail_img
      t.string :profile_img
      t.boolean :in_theaters, default: false

      t.timestamps
    end
  end
end
