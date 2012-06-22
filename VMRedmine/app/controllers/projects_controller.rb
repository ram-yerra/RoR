class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    @offset, @limit = api_offset_and_limit
    @projects =  Project.find :all,
                        :limit  =>  @limit,
                        :offset =>  @offset

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
  
  # FlexGrid Data
  def project_grid_data
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
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
      @projects = Project.find(:all,
  	:order => sortname+' '+sortorder,
  	:limit =>rp,
  	:offset =>start
  	)
      count = Project.count(:all)
    end

    # User provided search terms
    if(query != "%%")
        @projects = Project.find(:all,
    	    :order => sortname+' '+sortorder,
    	    :limit =>rp,
      	  :offset =>start,
      	  :conditions=>[qtype +" like ?", query])
    	    count = Project.count(:all,
    	    :conditions=>[qtype +" like ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @projects.collect{|p| {
           :id=>p.id,
           :cell=>["<a href=''></a>",
           "<image src='assets/edit.png' alt='edt' style='cursor:pointer;'/>",
           "<a href='projects/destroy/#{p.id}'><image src='assets/delete.png' alt='del' style='cursor:pointer;'/></a>",
           p.id,
           p.projectname,
  			   p.subprojectof,
   			   p.identifier
      ]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end  
  
end
