class HistoriesController < ApplicationController
  before_filter :login_required

  # GET /history
  # GET /history.xml
  def index
    @histories = History.find(:all)

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @histories }
    end
  end

  # GET /history/1
  # GET /history/1.xml
  def show
    @history = History.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @history }
    end
  end

  # GET /history/new
  # GET /history/new.xml
  def new
    @history = History.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @history }
    end
  end

  # GET /history/1/edit
  def edit
    @history = History.find(params[:id])
  end

  # POST /history
  # POST /history.xml
  def create
    @history = History.new(params[:history])

    respond_to do |format|
      if @history.save
        flash[:notice] = 'History was successfully created.'
        format.html { redirect_to(history_path(@history)) }
        format.xml  { render :xml => @history, :status => :created, :location => @history }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /history/1
  # PUT /history/1.xml
  def update
    @history = History.find(params[:id])

    respond_to do |format|
      if @history.update_attributes(params[:history])
        flash[:notice] = 'History was successfully updated.'
        format.html { redirect_to(history_path(@history)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /history/1
  # DELETE /history/1.xml
  def destroy
    @history = History.find(params[:id])
    @history.destroy

    respond_to do |format|
      format.html { redirect_to(histories_url) }
      format.xml  { head :ok }
    end
  end
end
