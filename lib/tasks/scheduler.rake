desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Processing orders..."
  Event.processOrders
  puts "done."
end