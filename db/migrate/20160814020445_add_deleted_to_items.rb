class AddDeletedToItems < ActiveRecord::Migration
  def change
    add_column :items, :deleted, :boolean, default: false
  end
end
