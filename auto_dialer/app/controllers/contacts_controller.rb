require 'fastercsv'

class ContactsController < ApplicationController
  
  before_filter :login_required
  
  # GET /contact
  # GET /contact.xml
  def index
    @contacts = Contact.paginate :page => params[:page], :order => :last_name, :per_page => 25 
    @tags = Contact.get_tags

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @contacts }
    end
  end
  def filter
    @tags = Contact.get_tags
    if params[:tag].nil?
      filter = params[:id]
    else
      filter = params[:tag]
    end
       
    unless filter == "All"
      @contacts = Contact.paginate :page => params[:page], :order => :last_name, :per_page => 25, :conditions => ["tags like ?", "%#{filter}%"]
      @tag = filter
    else
      @contacts = Contact.paginate :page => params[:page], :order => :last_name, :per_page => 25       
    end
    render :action => 'index'
  end
  
  # GET /contact/1
  # GET /contact/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contact/new
  # GET /contact/new.xml
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contact/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contact
  # POST /contact.xml
  def create
    @contact = Contact.new(params[:contact])
    @contact.account_id = current_user.account_id
    
    respond_to do |format|
      if @contact.save
        flash[:notice] = 'Contact was successfully created.'
        format.html { redirect_to(contact_path(@contact)) }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contact/1
  # PUT /contact/1.xml
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        flash[:notice] = 'Contact was successfully updated.'
        format.html { redirect_to(contact_path(@contact)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contact/1
  # DELETE /contact/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end
  def export
    s = Contact.find(:all)
    stream_csv do |csv|
      csv << ["first_name","last_name","phone","email", "cell", "address1", "address2", 
              "city", "state", "country", "post_code", "time_zone", "tags", 
              "custom0", "custom1", "custom2", "custom3", "custom4"]
      s.each do |u|
        csv << [u.first_name,u.last_name,u.phone,u.email, u.cell, u.address1, u.address2, u.city, u.state, u.country, u.post_code, u.time_zone, u.tags,
          u.custom0, u.custom1, u.custom2, u.custom3, u.custom4 ]
      end
    end
  end
  def import
   FasterCSV.parse(params[:filename]) do |info|
      first, last, phone, email, cell, address1, address2, city, state, country, post_code, time_zone, tags, 
      custom0,  custom1, custom2, custom3, custom4,= 
      info[0], info[1], info[2], info[3], info[4], info[5], info[6], info[7], info[8], info[9], info[10], info[11], info[12],
      info[13],  info[14],  info[15],  info[16],  info[17] 
      unless first.downcase == "first_name"  
        puts "Looking for #{first} and #{phone}"
        contact = Contact.find_by_phone(phone)
        puts "Found contact #{contact.id}" unless contact.nil?
        contact = Contact.new if contact.nil?
        contact.first_name = first
        contact.last_name = last
        contact.phone = phone
        contact.email = email
        contact.cell = cell
        contact.address1 = address1
        contact.address2 = address2
        contact.city = city
        contact.state = state
        contact.country = country
        contact.post_code = post_code
        contact.time_zone = time_zone
        contact.tags = tags
        contact.custom0 = custom0
        contact.custom1 = custom1
        contact.custom2 = custom2
        contact.custom3 = custom3
        contact.custom4 = custom4
        puts "The contact is invalid" unless contact.valid?
        contact.save
      end
    end
    redirect_to :action => 'index'
  end
  
  def delete_contacts
    Contact.delete_all
    redirect_to :action => 'index'
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
