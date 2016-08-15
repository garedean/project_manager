class ItemsController < ApplicationController
  before_action :set_project
  before_action :set_item, only: [:edit, :update]
  before_action :set_breadcrumb

  def set_breadcrumb
    add_breadcrumb 'Projects', :projects_path
    add_breadcrumb @project.title, project_path(@project)
  end

  def new
    @item = @project.items.build

    add_breadcrumb 'New Item'
  end

  def create
    @item = @project.items.build(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to project_path(@project),
                      :notice => 'Item was successfully created.' }
      else
        format.html { render :action => 'new' }
        add_breadcrumb "New Item"
      end
    end
  end

  def edit
    add_breadcrumb @item.action
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to project_path(@project),
                      :notice => 'Item was successfully updated.' }
      else
        format.html { render :action => 'edit' }
        add_breadcrumb @item.action_was
      end
    end
  end

private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_item
    @item = @project.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:action, :done)
  end
end
