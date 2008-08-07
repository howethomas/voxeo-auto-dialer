class DashboardController < ApplicationController
  before_filter :login_required
  
  def index
  end

  def status
    @running_schedules = Schedule.find_all_by_state("running")
    @upcoming_tasks = Task.find_all_by_started(false)

    @engine_output = %x[tail -n 100 log/engine.log]
    @server_output = %x[tail -n 100 log/#{RAILS_ENV}.log]
  end
  
  def download_engine_log
    send_file "log/engine.log"
  end
  
  def download_web_log
    send_file "log/#{RAILS_ENV}.log"
  end
end
