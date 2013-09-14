class Content < ActiveRecord::Base
  attr_accessor :body

  has_attached_file :body, {
    :styles => {
      :large  => "300x300>"
    }
  }

  validates_attachment :body,
    presence: true,
    content_type: { content_type: ["image/jpg", "image/png"] },
    size: { less_than: 2.megabytes }

end
