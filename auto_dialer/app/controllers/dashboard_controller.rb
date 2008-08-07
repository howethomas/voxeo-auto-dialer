class DashboardController < ApplicationController
  before_filter :login_required
  
  def index
  end

  def status
    @running_schedules = Schedule.find_all_by_state("running")
    @upcoming_tasks = Task.find_all_by_started(false)

    @engine_output =''
    lines = 100
    File.open(File.join(RAILS_ROOT, "log/engine.log")) do |f|
      f.readlines[-lines, lines].each do |line|
        @engine_output << line
      end
    end
    
    @server_output =''
    lines = 100
    File.open(File.join(RAILS_ROOT, "log/#{RAILS_ENV}.log")) do |f|
      f.readlines[-lines, lines].each do |line|
        @server_output << line
      end
    end
  end
  
  def download_engine_log
    send_file "log/engine.log"
  end
  
  def download_web_log
    send_file "log/#{RAILS_ENV}.log"
  end
end
