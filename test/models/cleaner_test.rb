require 'test_helper'

class CleanerTest < ActiveSupport::TestCase

  test "cleaner" do
    create_archive 'archive_1', Time.now - 63*60
    create_archive 'archive_2', Time.now - 62*60
    create_archive 'archive_3', Time.now - 61*60
    create_archive 'archive_4', Time.now - 60*60
    create_archive 'archive_5', Time.now - 59*60
    create_archive 'archive_6', Time.now - 58*60
    create_archive 'archive_7'
    create_archive 'archive_8'

    assert_equal 8, Archive.count

    Fetchshare::Cleaner.clean

    assert_equal 4, Archive.count
  end

  def create_archive(name, created_at = nil)
    params = {}
    params[:name]     = name
    params[:content]  = name

    archive = Archive.new
    archive.created_at = created_at if created_at
    archive.create_archive params
  end

end
