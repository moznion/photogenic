class AddindexToContents < ActiveRecord::Migration
  def change
    add_index :contents, :name
    add_index :contents, :last_accessed_at
  end
end
