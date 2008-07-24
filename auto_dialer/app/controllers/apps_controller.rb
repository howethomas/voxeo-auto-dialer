class AppsController < ApplicationController
  # GET /app
  # GET /app.xml
  def index
    @apps = App.find(:all)

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @apps }
    end
  end

  # GET /app/1
  # GET /app/1.xml
  def show
    @app = App.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @app }
    end
  end

  # GET /app/new
  # GET /app/new.xml
  def new
    @app = App.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @app }
    end
  end

  # GET /app/1/edit
  def edit
    @app = App.find(params[:id])
  end

  # POST /app
  # POST /app.xml
  def create
    @app = App.new(params[:app])

    respond_to do |format|
      if @app.save
        flash[:notice] = 'App was successfully created.'
        format.html { redirect_to(app_path(@app)) }
        format.xml  { render :xml => @app, :status => :created, :location => @app }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @app.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /app/1
  # PUT /app/1.xml
  def update
    @app = App.find(params[:id])

    respond_to do |format|
      if @app.update_attributes(params[:app])
        flash[:notice] = 'App was successfully updated.'
        format.html { redirect_to(app_path(@app)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @app.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /app/1
  # DELETE /app/1.xml
  def destroy
    @app = App.find(params[:id])
    @app.destroy

    respond_to do |format|
      format.html { redirect_to(apps_url) }
      format.xml  { head :ok }
    end
  end
end
