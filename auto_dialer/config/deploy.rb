# This is a sample Capistrano config file for EC2 on Rails.
# It should be edited and customized.

set :application, "voxeo-auto-dialer"

# Git/Github setup
set :scm, :git
set :repository,  "git@github.com:howethomas/voxeo-auto-dialer.git"


# NOTE: for some reason Capistrano requires you to have both the public and
# the private key in the same folder, the public key should have the 
# extension ".pub".
ssh_options[:keys] = ["#{ENV['HOME']}/.ec2/ec2-keypair"]

# Your EC2 instances. Use the ec2-xxx....amazonaws.com hostname, not
# any other name (in case you have your own DNS alias) or it won't
# be able to resolve to the internal IP address.
role :web,      "ec2-75-101-211-73.compute-1.amazonaws.com"
role :app,      "ec2-75-101-211-73.compute-1.amazonaws.com"
role :db,       "ec2-75-101-211-73.compute-1.amazonaws.com", :primary => true
role :memcache, "ec2-75-101-211-73.compute-1.amazonaws.com"

# Whatever you set here will be taken set as the default RAILS_ENV value
# on the server. Your app and your hourly/daily/weekly/monthly scripts
# will run with RAILS_ENV set to this value.
set :rails_env, "production"

# EC2 on Rails config. 
# NOTE: Some of these should be omitted if not needed.
set :ec2onrails_config, {
  # S3 bucket and "subdir" used by the ec2onrails:db:restore task
  :restore_from_bucket => "auto_dialer",
  :restore_from_bucket_subdir => "database",
  
  # S3 bucket and "subdir" used by the ec2onrails:db:archive task
  # This does not affect the automatic backup of your MySQL db to S3, it's
  # just for manually archiving a db snapshot to a different bucket if 
  # desired.
  :archive_to_bucket => "other_auto_dialer",
  :archive_to_bucket_subdir => "db-archive/#{Time.new.strftime('%Y-%m-%d--%H-%M-%S')}",
  
  
  # Any extra Ubuntu packages to install if desired
  # If you don't want to install extra packages then remove this.
  :packages => ["logwatch", "imagemagick"],
  
  # Any extra RubyGems to install if desired: can be "gemname" or if a 
  # particular version is desired "gemname -v 1.0.1"
  # If you don't want to install extra rubygems then remove this
  :rubygems => ["chronic", "mislav-will_paginate --source http://gems.github.com/", "haml"],
  
  # Set the server timezone. run "cap -e ec2onrails:server:set_timezone" for 
  # details
  :timezone => "Canada/Eastern",
  
   # If config files are deployed, some services might need to be restarted.
  # If you don't need to deploy customized config files to the server then
  # remove this.
  :services_to_restart => %w(apache2 postfix sysklogd),
  
  # Set an email address to forward admin mail messages to. If you don't
  # want to receive mail from the server (e.g. monit alert messages) then
  # remove this.
  :admin_mail_forward_address => "howethomas@aol.com"
}
