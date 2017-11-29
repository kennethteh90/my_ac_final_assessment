class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.references :follower
      t.references :followee

      t.timestamps
    end
    add_foreign_key :relationships, :users, column: :follower_id
    add_foreign_key :relationships, :users, column: :followee_id
  end
end
