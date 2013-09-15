class Tasks::AutoRemove
  def self.execute
    now_epoch            = Time.now.gmtime.to_i
    delta_time_epoch     = 86400 # <= 24 hours
    out_dated_following  = false

    Content.order('last_accessed_at DESC').each do |content|
      if out_dated_following
        content.delete
        next
      end

      last_accessed_at_epoch = content.last_accessed_at.gmtime.to_i
      if now_epoch - last_accessed_at_epoch > delta_time_epoch
        content.delete
        out_dated_following = true
      end
    end
  end
end
