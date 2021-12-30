class GroupsController < ApplicationController
  before_action :owner?, only: [:edit]
  def index
   @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    current_user.groups.create(group_params)
    redirect_to groups_path
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.users
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

  def join
    GroupUser.create(group_id: params[:id].to_i, user_id: current_user.id)
    redirect_to groups_path
  end

  def leave
    @gu = GroupUser.find_by(group_id: params[:id].to_i, user_id: current_user.id)
    @gu.destroy
    redirect_to groups_path
  end

  private
    def group_params
      params.require(:group).permit(:name, :introduction, :image).merge(owner_id: current_user.id)
    end

    def owner?
      @group = Group.find(params[:id])
      redirect_to groups_path unless @group.owned?(current_user)
    end

end
