class OptionsController < ApplicationController
  # GET /option
  # GET /option.xml
  def index
    @option = Option.find(:first)      
    
    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @options }
    end
  end


  # GET /option/1/edit
  def edit
    @option = Option.first
  end

  # PUT /option/1
  # PUT /option/1.xml
  def update
    @option = Option.first

    respond_to do |format|
      if @option.update_attributes(params[:option])
        flash[:notice] = 'Option was successfully updated.'
        if @option.mock?
          flash[:error] = 'Dialer is in mock mode. No actual calls are going through.' 
        else
          flash.discard(:error )
        end
        format.html { render :action => "index"}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @option.errors, :status => :unprocessable_entity }
      end
    end
  end
end
