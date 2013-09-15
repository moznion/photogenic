class AddExtensionToContents < ActiveRecord::Migration
  def change
    add_column :contents, :extension, :string
  end
end
