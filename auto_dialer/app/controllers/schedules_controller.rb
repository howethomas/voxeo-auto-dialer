require "chronic"

class SchedulesController < ApplicationController
  before_filter :login_required

  # GET /schedule
  # GET /schedule.xml
  def index
    @schedules = Schedule.find(:all)
    @apps = App.find(:all)
    
    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @schedules }
    end
  end

  # GET /schedule/1
  # GET /schedule/1.xml
  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedule/new
  # GET /schedule/new.xml
  def new
    @schedule = Schedule.new
    @apps = App.find(:all)
    
    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedule/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
    @apps = App.find(:all)
  end

  # POST /schedule
  # POST /schedule.xml
  def create
    @schedule = Schedule.new(params[:schedule])
    @schedule.start = Chronic.parse(params[:schedule][:start])
    @schedule.app_id = params[:schedule][:app_id]
    
    respond_to do |format|
      if @schedule.save
        flash[:notice] = 'Schedule was successfully created.'
        format.html { redirect_to(schedule_path(@schedule)) }
        format.xml  { render :xml => @schedule, :status => :created, :location => @schedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schedule/1
  # PUT /schedule/1.xml
  def update
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        flash[:notice] = 'Schedule was successfully updated.'
        format.html { redirect_to(schedule_path(@schedule)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schedule/1
  # DELETE /schedule/1.xml
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to(schedules_url) }
      format.xml  { head :ok }
    end
  end
end
