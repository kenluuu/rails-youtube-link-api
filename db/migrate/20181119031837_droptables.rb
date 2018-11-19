class Droptables < ActiveRecord::Migration[5.1]
  def change
    drop_table :youtubes
    drop_table :youtube_links
  end
end
