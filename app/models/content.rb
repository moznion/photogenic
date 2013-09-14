class Content < ActiveRecord::Base
  attr_accessor :body

  has_attached_file :body, {
    styles: {
      large: "300x300>"
    },
    path: ":rails_root/public/sys_img/:id_sha1.:extension",
    url:  "#{ActionController::Base.relative_url_root}/sys_img/:id_sha1.:extension"
  }

  validates_attachment :body,
    presence: true,
    content_type: { content_type: ["image/jpg", "image/png"] },
    size: { less_than: 2.megabytes }

end
