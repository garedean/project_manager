class ProjectsController < ApplicationController
  before_action :set_project, :except => [:index, :new, :create]

  def index
    @projects = Project.where(deleted: false)

  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path(@project),
                      :notice => 'Project was successfully created.' }
      else
        format.html { render :action => 'new' }
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
    cleared_projects = @project.items.complete.destroy_all

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
