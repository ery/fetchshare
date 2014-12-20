namespace :fetchshare do

  desc 'Clean'
  task :clean => :environment do
    puts "Fetchshare clean"
    puts "=============================="

    if Rails.env.production?
      interval = 60
    else
      interval = 2
    end

    loop do
      report do
        Fetchshare::Cleaner.clean
        sleep interval
      end
    end
  end

  def report
    puts "Check at #{Time.now}"
    puts "----------------------"
    yield
    puts ""
  end

end
