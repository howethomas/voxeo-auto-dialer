class GroupsController < ApplicationController
  before_filter :login_required
 
  # GET /group
  # GET /group.xml
  def index
    @groups = Group.find(:all)

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @groups }
    end
  end

  # GET /group/1
  # GET /group/1.xml
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @group }
    end
  end

  # GET /group/new
  # GET /group/new.xml
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @group }
    end
  end

  # GET /group/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /group
  # POST /group.xml
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(group_path(@group)) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /group/1
  # PUT /group/1.xml
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(group_path(@group)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /group/1
  # DELETE /group/1.xml
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
end
