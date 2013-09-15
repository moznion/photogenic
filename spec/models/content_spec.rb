require 'spec_helper'

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
