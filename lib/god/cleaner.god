
God.watch do |w|
  w.name = "cleaner"
  w.start = "rake fetchshare:cleaner"
  w.keepalive
end
