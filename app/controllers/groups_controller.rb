class GroupsController < ApplicationController
  before_action :owner?, only: [:edit]
  def index
   @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.create(group_params)
    redirect_to groups_path
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to @group
    else
      render 'edit'
    end
  end

  private
    def group_params
      params.require(:group).permit(:name, :introduction, :image).merge(owner_id: current_user.id)
    end

    def owner?
      @group = Group.find(params[:id])
      redirect_to groups_path unless @group.owner_id == current_user.id
    end

end
