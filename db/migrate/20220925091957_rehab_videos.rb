class RehabVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :rehab_videos, id: :bigserial do |t|
      t.integer :category, null: false
      t.string :title, null: false
      t.timestamps
    end
  end
end
