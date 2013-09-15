include ActionDispatch::TestProcess

FactoryGirl.define do
  tempfile           = Tempfile.new('valid', [Rails.root, 'spec', 'fixtures', 'images'].join("/"))
  too_large_tempfile = Tempfile.new('too_large', [Rails.root, 'spec', 'fixtures', 'images'].join("/"))

  str = ''
  (1024 * 1024 * 5 + 1).times do
    str << 'a'
  end
  too_large_tempfile.print str

  factory :valid_jpg_content, :class => Content do |c|
    c.body { fixture_file_upload([Rails.root, 'spec', 'fixtures', 'images', 'test.jpg'].join("/"), "image/jpeg") }
  end

  factory :valid_png_content, :class => Content do |c|
    c.body { fixture_file_upload(tempfile.path, "image/png") }
  end

  factory :valid_gif_content, :class => Content do |c|
    c.body { fixture_file_upload(tempfile.path, "image/gif") }
  end

  factory :invalid_file_type_content, :class => Content do |c|
    c.body { fixture_file_upload(tempfile.path, "text/plain") }
  end

  factory :invalid_too_large_content, :class => Content do |c|
    c.body { fixture_file_upload(too_large_tempfile.path, "image/jpeg") }
  end
end

