# Only seed if no pages exist (idempotent)
unless Panda::CMS::Page.any?
  Panda::CMS::SanctuaryDemo.generate!
  puts "Demo site seeded with Panda Sanctuary content"
end
