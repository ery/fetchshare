module Fetchshare
  module ArchiveFile

    def self.save_file(archive, upload_file)
      return unless upload_file

      create_file_folder

      random_number = SecureRandom.random_number(10000)
      file_name     = "#{random_number}_#{upload_file.original_filename}"
      file_path     = get_file_path(file_name)

      File.open(file_path, 'wb') do |file|
        file.write(upload_file.read)
      end

      archive.file_name        = file_name
      archive.file_origin_name = upload_file.original_filename
    end

    def self.get_file_path(file_name)
      file_path = Rails.root.join('public', 'storage', file_name)
      return file_path
    end

    def self.create_file_folder
      folder_path = Rails.root.join('public', 'storage')

      return if Dir.exists?(folder_path)

      FileUtils.mkdir_p(folder_path)
    end

  end
end
