class CreateYoutubeLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :youtube_links do |t|
      t.string :url
      t.string :video_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
