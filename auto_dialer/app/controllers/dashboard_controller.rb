class DashboardController < ApplicationController
  before_filter :login_required
  
  def index
  end

  def status
    @running_schedules = Schedule.find_all_by_state("running")
    @upcoming_tasks = Task.find_all_by_started(false)
  end

end
