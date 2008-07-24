class AccountsController < ApplicationController
  # GET /account
  # GET /account.xml
  def index
    @accounts = Account.find(:all)

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @accounts }
    end
  end

  # GET /account/1
  # GET /account/1.xml
  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @account }
    end
  end

  # GET /account/new
  # GET /account/new.xml
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @account }
    end
  end

  # GET /account/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /account
  # POST /account.xml
  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        flash[:notice] = 'Account was successfully created.'
        format.html { redirect_to(account_path(@account)) }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /account/1
  # PUT /account/1.xml
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        flash[:notice] = 'Account was successfully updated.'
        format.html { redirect_to(account_path(@account)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /account/1
  # DELETE /account/1.xml
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml  { head :ok }
    end
  end
end
