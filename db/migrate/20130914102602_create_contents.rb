class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string            :name
      t.has_attached_file :body
      t.datetime          :last_accessed_at

      t.timestamps
    end
  end
end
