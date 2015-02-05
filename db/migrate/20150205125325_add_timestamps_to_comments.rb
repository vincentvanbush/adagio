class AddTimestampsToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.timestamps null: false
    end
  end
end
