class UsersController < ApplicationController

  respond_to :html, :xml, :json, :js
    
  # GET /users
  # GET /users.json
  def index
    @offset, @limit = api_offset_and_limit
    @users =  User.find :all,
                        :limit  =>  @limit,
                        :offset =>  @offset

    respond_to do |format|
      format.html # index.html.erb
      format.js  { render :json => @users, :callback => params[:callback] }
      format.json { render json: @users, :callback => params[:callback] }
    end
  end 
  

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.js  { render :json => @user, :callback => params[:callback] }
      format.json { render :json => @user, :callback => params[:callback]  }
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new    
    respond_to do |format|
      format.html # new.html.erb
      format.js  { render :json => @user, :callback => params[:callback] }
      format.json { render :json => @user, :callback => params[:callback]  }           
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver
        format.html { 
        flash[:notice] = 'User was successfully created.'
        redirect_to @user }
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { 
        #flash[:notice] = 'User was successfully created.' 
        redirect_to @user, notice: 'User was successfully updated.' 
        
        }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy    
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # FlexGrid Data
  def grid_data
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "firstname"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @users = User.find(:all,
  	:order => sortname+' '+sortorder,
  	:limit =>rp,
  	:offset =>start
  	)
      count = User.count(:all)
    end

    # User provided search terms
    if(query != "%%")
        @users = User.find(:all,
	    :order => sortname+' '+sortorder,
	    :limit =>rp,
  	  :offset =>start,
  	  :conditions=>[qtype +" like ?", query])
	    count = User.count(:all,
	    :conditions=>[qtype +" like ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @users.collect{|u| {
           :id=>u.id, 
           :cell=>["<a href=''></a>",
           "<image src='assets/edit.png' alt='edt' style='cursor:pointer;'/>",
           "<a href='users/destroy/#{u.id}'><image src='assets/delete.png' alt='del' style='cursor:pointer;'/></a>",
           u.id,
           u.firstname,
  			   u.lastname,
   			   u.email,
      ]}}

    # Convert the hash to a json object
    # render :text=>return_data.to_json, :callback => params[:callback], :layout=>false
    respond_to do |format|      
      format.js  { render :json=>return_data, :callback => params[:callback], :layout=>false }
      format.json { render :json => return_data, :callback => params[:callback], :layout=>false }           
    end    
  end  
 
end 