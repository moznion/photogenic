class AddColumnsToContents < ActiveRecord::Migration
  def change
    add_column :contents, :name, :string
    add_column :contents, :category, :string
    add_column :contents, :mime, :string
    add_column :contents, :body, :binary
    add_column :contents, :last_accessed_at, :date
  end
end
