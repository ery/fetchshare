module Fetchshare
  module Cleaner

    def self.clean
      time_boundary = (Time.now - 60*60)

      archives = Archive
      archives = archives.where("created_at < ?", time_boundary)

      archives_count = archives.count
      if archives_count == 0
        return
      end

      puts "Archive count: #{Archive.count}"
      archives.destroy_all
      puts "Clean overdue #{archives_count} archives."
      puts "Archive count: #{Archive.count}"
    end

  end
end
