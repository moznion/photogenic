class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string            :name
      t.string            :category
      t.string            :mime
      t.has_attached_file :body
      t.date              :last_accessed_at

      t.timestamps
    end
  end
end
