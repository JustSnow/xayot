class Admin::UsersController < Admin::AdminController
  before_filter :find_user, only: [:edit, :update]

  def index
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Пользователь #{@user.email} успешно обновлен"
      redirect_to [:edit, :admin, @user]
    else
      flash[:alert] = "При создании возникли ошибки"
      render 'edit'
    end
  end

  def destroy
  end

  private
    def find_user
      @user = User.find(params[:id])
    end
end