class ModelsController < ApplicationController
  before_filter :login_required
  
  # GET /Model
  # GET /Model.xml
  def index
    @models = Model.find(:all)

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @models }
    end
  end

  # GET /Model/1
  # GET /Model/1.xml
  def show
    @model = Model.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @model }
    end
  end

  # GET /Model/new
  # GET /Model/new.xml
  def new
    @model = Model.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @model }
    end
  end

  # GET /Model/1/edit
  def edit
    @model = Model.find(params[:id])
  end

  # POST /Model
  # POST /Model.xml
  def create
    @model = Model.new(params[:model])

    respond_to do |format|
      if @model.save
        flash[:notice] = 'Model was successfully created.'
        format.html { redirect_to(model_path(@model)) }
        format.xml  { render :xml => @model, :status => :created, :location => @model }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /Model/1
  # PUT /Model/1.xml
  def update
    @model = Model.find(params[:id])

    respond_to do |format|
      if @model.update_attributes(params[:model])
        flash[:notice] = 'Model was successfully updated.'
        format.html { redirect_to(model_path(@model)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /Model/1
  # DELETE /Model/1.xml
  def destroy
    @model = Model.find(params[:id])
    @model.destroy

    respond_to do |format|
      format.html { redirect_to(models_url) }
      format.xml  { head :ok }
    end
  end
end
