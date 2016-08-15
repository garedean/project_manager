class ProjectsController < ApplicationController
  before_action :set_project, :except => [:index, :new, :create]
  before_action :set_breadcrumb

  def set_breadcrumb
    add_breadcrumb "Projects", :root_path
    add_breadcrumb @project.title, project_path(@project) if @project
  end

  def index
    @projects = Project.where(deleted: false)
  end

  def show
  end

  def new
    @project = Project.new
    add_breadcrumb "New Project", new_project_path
  end

  def edit
    add_breadcrumb @project.title
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path(@project),
                      :notice => 'Project was successfully created.' }
      else
        format.html { render :action => 'new' }
        add_breadcrumb "New Project"
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(@project),
                      :notice => 'Project was successfully updated.' }
      else
        format.html { render :action => 'edit' }
        add_breadcrumb @project.title_was
      end
    end
  end

  def destroy
    @project.soft_delete
    respond_to do |format|
      format.html { redirect_to projects_path,
                    :notice => 'Project was successfully destroyed.' }
    end
  end

  def clear
    cleared_projects = Project.soft_delete_all(@project.items.complete_and_undeleted)

    respond_to do |format|
      format.html { redirect_to project_path(@project),
        :notice => cleared_flash_message(cleared_projects: cleared_projects) }
    end
  end

private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end

  def cleared_flash_message(cleared_projects:)
    if cleared_projects.any?
      'Completed items were successfully cleared.'
    else
      'There are no completed items for this project.'
    end
  end
end
