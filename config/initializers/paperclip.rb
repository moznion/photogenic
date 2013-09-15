#!/usr/bin/env ruby

Paperclip.interpolates :id_sha1 do |attachment, style|
  instance = attachment.instance
  str = instance.body_file_name + instance.body_file_size.to_s + instance.body_updated_at.to_s
  Digest::SHA1.hexdigest(str)
end
