class Content < ActiveRecord::Base
  attr_accessor :body

  validate :check_presence
  validate :check_content_type
  validate :check_file_size

  has_attached_file :body, {
    path: ":rails_root/public/resource/:id_sha1.:extension",
    url:  "#{ActionController::Base.relative_url_root}/resource/:id_sha1.:extension"
  }

  def check_presence
    unless self.body_file_name
      errors.add(:content, "ファイルを指定してください")
    end
  end

  def check_content_type
    if !['image/jpeg', 'image/gif','image/png'].include?(self.body_content_type)
      errors.add(:content_type, "'jpeg', 'gif', 'png' 以外のファイルはアップロード出来ません")
    end
  end

  def check_file_size
    if self.body_file_size > 1024 * 1024 * 5
      errors.add(:content_size, "5MBを超えるファイルはアップロード出来ません")
    end
  end
end
