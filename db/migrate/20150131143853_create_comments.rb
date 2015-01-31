class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment_type
      t.string :content
      t.references :contract, index: true
      t.references :author, index: true
      t.references :user_for, index: true
    end
    add_foreign_key :comments, :contracts
    add_foreign_key :comments, :users, column: :author_id
    add_foreign_key :comments, :users, column: :user_for_id
  end
end
