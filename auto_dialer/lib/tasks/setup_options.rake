namespace :thomas do
  desc "Setup the options table"
  task :options do
    `script/runner Utility.setup_options`
  end
end



# Make the options table if one doesn't exist
