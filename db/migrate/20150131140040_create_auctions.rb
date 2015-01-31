class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.string :description
      t.string :auction_type
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :finished_at
      t.decimal :price, precision: 10, scale: 2
      t.references :category, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :auctions, :categories
    add_foreign_key :auctions, :users
  end
end
