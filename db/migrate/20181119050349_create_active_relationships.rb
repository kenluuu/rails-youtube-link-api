class CreateActiveRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :active_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
  end
end
