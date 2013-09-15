class Tasks::AutoRemove
  def self.execute
    now_epoch = Time.now.gmtime.to_i
    delta_time_epoch = 86400 # <= 24 hours
    Content.all.each do |content|
      last_accessed_at_epoch = content.last_accessed_at.gmtime.to_i
      if now_epoch - last_accessed_at_epoch > delta_time_epoch
        content.destroy
      end
    end
  end
end
