class Admin::GroupsController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
    @group = Group.new(group_params)

    @group.save ? redirect_to(admin_groups_path) : render(:new)
  end

  def edit
  end

  def update
    group.update_attributes(group_params) ? redirect_to(admin_groups_path) : render(:edit)
  end

private

  def group_params
    params.require(:group).permit(:name)
  end

  def group
    @group ||= params[:id].present? ? Group.find(params[:id]) : Group.new
  end
  helper_method :group

  def groups
    @groups ||= Group.order(:name).page(params[:page])
  end
  helper_method :groups

end
