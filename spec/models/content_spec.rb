require 'spec_helper'

include ActionDispatch::TestProcess

FactoryGirl.define do
  tempfile             = Tempfile.new('valid', [Rails.root, 'spec', 'fixtures', 'images'].join("/"))
  too_large_tempfile = Tempfile.new('too_large', [Rails.root, 'spec', 'fixtures', 'images'].join("/"))

  str = ''
  (1024 * 1024 * 5 + 1).times do
    str << 'a'
  end
  too_large_tempfile.print str

  factory :valid_jpg_content, :class => Content do |c|
    c.body { fixture_file_upload(tempfile.path, "image/jpeg") }
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

describe Content do
  context '#new' do
    context 'validation' do
      context 'valid file' do
        context 'jpeg' do
          it 'should be accept with no any errors' do
            content = FactoryGirl.create(:valid_jpg_content)
            expect{content.check_presence}.not_to raise_error
            expect{content.check_content_type}.not_to raise_error
            expect{content.check_file_size}.not_to raise_error
          end
        end

        context 'png' do
          it 'should be accept with no any errors' do
            content = FactoryGirl.create(:valid_png_content)
            expect{content.check_content_type}.not_to raise_error
          end
        end

        context 'gif' do
          it 'should be accept with no any errors' do
            content = FactoryGirl.create(:valid_gif_content)
            expect{content.check_content_type}.not_to raise_error
          end
        end
      end

      context "invalid file" do
        context 'invalid file type' do
          it 'should be reject' do
            expect{FactoryGirl.create(:invalid_file_type_content)}.to raise_error
          end
        end

        context 'too large' do
          it 'should be reject' do
            expect{FactoryGirl.create(:invalid_too_large_content)}.to raise_error
          end
        end
      end
    end
  end
end
