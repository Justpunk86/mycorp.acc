class UsersController < ApplicationController
  before_action :authenticate_user!, :is_admin?
  # before_action :get_user_roles, only: [:index, :create, :destroy]

  def admin
    @users = User.all
    @roles = Role.all
    @admin = is_admin?

    @curr_roles = User.find(current_user.id).roles.to_a.map {|rn| rn.role_name }
  end

  def new
    
  end

  def create

    @user = User.find_by(email: params[:email])
    @role = @user.roles
    if @role << Role.find_by(role_name: params[:role_name])
      redirect_to '/users/admin'
    else
      render action: 'admin'
    end

  end

  def update

  end

  def destroy
    user = User.find(params[:user_id])

    if user.roles.delete(Role.find(params[:role_id]))
      redirect_to '/users/admin'
    else
      render action: 'admin'
    end

  end

  private

  def is_admin?
    roles = User.find(current_user.id).roles.to_a.map {|rn| rn.role_name }

    if roles.include?('admin')
      return true
    else
      render plain: "Access denied"
      # redirect_to '/'
    end
    
  end

  def get_user_params
    params.require(:users).permit(
        :email,
        :role_name
      )
  end

end
