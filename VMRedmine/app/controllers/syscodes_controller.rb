class SyscodesController < ApplicationController
  # GET /syscodes
  # GET /syscodes.json
  def index
    @offset, @limit = api_offset_and_limit
    @syscodes =  Syscode.find :all,
                        :limit  =>  @limit,
                        :offset =>  @offset

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @syscodes }
    end
  end

  # GET /syscodes/1
  # GET /syscodes/1.json
  def show
    @syscode = Syscode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @syscode }
    end
  end

  # GET /syscodes/new
  # GET /syscodes/new.json
  def new
    @syscode = Syscode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @syscode }
    end
  end
  
  def selectnew
    parent_id = (params[:parent_id])
    puts parent_id    
    @syscodes = Syscode.where("fksyscodeparent = '#{parent_id}'")
    count = Syscode.where("fksyscodeparent = '#{parent_id}'").count(:all) 
    respond_to do |format|
      format.html # selectnew.html.erb
      format.json { render json: @syscodes }
    end
  end

  def newIndex

    @offset, @limit = api_offset_and_limit
    @syscodes =  Syscode.find :all,
                        :limit  =>  @limit,
                        :offset =>  @offset

    respond_to do |format|
      format.html # newIndex.html.erb
      format.json { render json: @syscodes }
    end
  end

  # GET /syscodes/1/edit
  def edit
    @syscode = Syscode.find(params[:id])
  end

  # POST /syscodes
  # POST /syscodes.json
  def create
    @syscode = Syscode.new(params[:syscode])

    respond_to do |format|
      if @syscode.save
        format.html { redirect_to @syscode, notice: 'Syscode was successfully created.' }
        format.json { render json: @syscode, status: :created, location: @syscode }
      else
        format.html { render action: "new" }
        format.json { render json: @syscode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /syscodes/1
  # PUT /syscodes/1.json
  def update
    @syscode = Syscode.find(params[:id])
    
    respond_to do |format|
      if @syscode.update_attributes(params[:syscode])
        format.html { redirect_to @syscode, notice: 'Syscode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @syscode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /syscodes/1
  # DELETE /syscodes/1.json
  def destroy
    @syscode = Syscode.find(params[:id])
    @syscode.destroy

    respond_to do |format|
      format.html { redirect_to syscodes_url }
      format.json { head :no_content }
    end
  end
  
  # FlexGrid Data
  def syscode_data
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "syscode"
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
      @syscodes = Syscode.where("fksyscodeparent = '0'",
      	:order => sortname+' '+sortorder,
      	:limit =>rp,
      	:offset =>start
    	)
      count = Syscode.where("fksyscodeparent = '0'").count(:all)
    end

    # User provided search terms
    if(query != "%%")
        @syscodes = Syscode.where("fksyscodeparent = '0'",
	    :order => sortname+' '+sortorder,
	    :limit =>rp,
  	  :offset =>start,
  	  :conditions=>[qtype +" like ?", query])
	    count = Syscode.where("fksyscodeparent = '0'").count(:all,
	    :conditions=>[qtype +" like ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @syscodes.collect{|s| {
           :id=>s.id,
           :cell=>["<a href='#'></a>",
           "<image src='assets/edit.png' alt='edt' style='cursor:pointer;'/>",
           "<a href='syscodes/destroy/#{s.id}'><image src='assets/delete.png' alt='del' style='cursor:pointer;'/></a>",
           s.id,
           s.syscode,
           s.isactive
      ]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end 

  def syscode_child_data
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "syscode"
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
      @syscodes = Syscode.where("fksyscodeparent != '0'",
  	:order => sortname+' '+sortorder,
  	:limit =>rp,
  	:offset =>start
  	)
      count = Syscode.where("fksyscodeparent != '0'").count(:all)
    end

    # User provided search terms
    if(query != "%%")
        @syscodes = Syscode.where("fksyscodeparent != '0'",
	    :order => sortname+' '+sortorder,
	    :limit =>rp,
  	  :offset =>start,
  	  :conditions=>[qtype +" like ?", query])
	    count = Syscode.where("fksyscodeparent != '0'").count(:all,
	    :conditions=>[qtype +" like ?", query])
    end 
                                                
    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @syscodes.collect{|s| {
           :id=>s.id,
           :cell=>["<a href='#'></a>",
           "<image src='assets/edit.png' alt='edt' style='cursor:pointer;'/>",
           "<a href='syscodes/destroy/#{s.id}'><image src='assets/delete.png' alt='del' style='cursor:pointer;'/></a>",
           s.id,
           s.syscode,
           s.syscode_desc,
           s.isactive,
           s.fksyscodeparent
      ]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end   

  def syscode_display_data
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]
    idt = params[:idt]
    
    if (!sortname)
      sortname = "syscode"
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
      @syscodes = Syscode.where("fksyscodeparent = '#{idt}'",
  	:order => sortname+' '+sortorder,
  	:limit =>rp,
  	:offset =>start
  	)
      count = Syscode.where("fksyscodeparent = '#{idt}'").count(:all)
    end

    # User provided search terms
    if(query != "%%")
        @syscodes = Syscode.where("fksyscodeparent = '#{idt}'",
	    :order => sortname+' '+sortorder,
	    :limit =>rp,
  	  :offset =>start,
  	  :conditions=>[qtype +" like ?", query])
	    count = Syscode.where("fksyscodeparent = '#{idt}'").count(:all,
	    :conditions=>[qtype +" like ?", query])
    end 
                                                
    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @syscodes.collect{|s| {
           :id=>s.id,
           :cell=>["<a href='#'></a>",
           "<image src='assets/edit.png' alt='edt' style='cursor:pointer;'/>",
           "<a href='syscodes/destroy/#{s.id}'><image src='assets/delete.png' alt='del' style='cursor:pointer;'/></a>",
           s.id,
           s.syscode,
           s.syscode_desc,
           s.fksyscodeparent,
           s.isactive
      ]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end
end
