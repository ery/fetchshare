class Archive < ActiveRecord::Base
  belongs_to :folder
  validate :validate_content
  before_save :binding_folder

  attr_accessor :location

  default_scope { order('created_at DESC') }

  scope :root, ->{ where(:folder_id => nil) }

  after_destroy :destroy_file

  def create_archive(params)
    archive = self
    archive.name     = params[:name]
    archive.content  = params[:content]
    archive.location = params[:location]

    Fetchshare::ArchiveFile.save_file archive, params[:file]

    archive.save!
  end

  def validate_content
    return if self.content.present?
    return if self.file_name.present?

    raise itext(:plesase_input_content)
  end

  def binding_folder
    archive = self
    return unless archive.location.present?

    self.folder = Folder.find_by_name(archive.location)
    unless self.folder
      self.folder = Folder.create!(:name => archive.location)
    end
  end

  def destroy_file
    if self.is_include_file?
      FileUtils.rm self.file_path
    end
  end

  def created_at_text
    self.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  def smart_name
    if self.name.present?
      return self.name
    end

    if self.file_name.present?
      return self.smart_file_name
    end

    if self.content.present?
      return self.content[0, 5]
    end

    return "NoName"
  end

  def smart_file_name
    name = self.file_origin_name
    if name.size < 10
      return name
    else
      return "#{name[0, 5]}...#{name[-5, 5]}"
    end
  end

  def file_path
    return Fetchshare::ArchiveFile.get_file_path(self.file_name)
  end

  def is_include_file?
    if self.file_name.present?
      return true
    else
      return false
    end
  end

  def self.find_archives(params)
    location = params[:location]

    if location.blank?
      archives = Archive.root
      return archives
    end

    folder = Folder.find_by_name(location)
    if folder
      archives = folder.archives
      return archives
    end

    return []
  end

end
