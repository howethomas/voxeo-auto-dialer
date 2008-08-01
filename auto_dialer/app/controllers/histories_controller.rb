class HistoriesController < ApplicationController
  before_filter :login_required

  # GET /history
  # GET /history.xml
  def index
    @histories = History.paginate :page => params[:page], :order => "created_at DESC", :per_page => 25 

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
  
  def export
    s = History.find(:all)
    stream_csv do |csv|
      csv << ["schedule","contact_id", "phone", "result","created_at"]
      s.each do |u|
        schedule = u.schedule.nil? ? "Schedule deleted" : u.schedule.name
        contact_id = u.contact.nil? ? "Contact deleted" : u.contact.id
        phone = u.contact.nil? ? "Contact deleted" : u.contact.phone
        csv << [schedule, contact_id, phone,u.result,u.created_at]
      end
    end
    redirect_to(histories_url)
  end
  def delete_history
    History.delete_all
    respond_to do |format|
      format.html { redirect_to(histories_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def stream_csv
     filename = params[:action] + ".csv"    

     #this is required if you want this to work with IE        
     if request.env['HTTP_USER_AGENT'] =~ /msie/i
       headers['Pragma'] = 'public'
       headers["Content-type"] = "text/plain" 
       headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
       headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
       headers['Expires'] = "0" 
     else
       headers["Content-Type"] ||= 'text/csv'
       headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
     end

    render :text => Proc.new { |response, output|
      csv = FasterCSV.new(output, :row_sep => "\r\n") 
      yield csv
    }
  end
  
end
