class Admin::UsersController < Admin::AdminController
  before_filter :find_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.paginate(page: params[:page], per_page: 15)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new params[:user]
    password = Time.now.to_time
    @user.password = password
    @user.password_confirmation = password

    if @user.save
      flash[:notice] = "Пользователь '#{@user.first_name} #{@user.last_name}' успешно сохранен"
      redirect_to [:edit, :admin, @user]
    else
      flash[:alert] = "При сохранении возникли ошибки"
      render 'new'
    end
  end

  def update
    # params[:user].delete([:password, :password_confirmation]) if params[:user][:password].blank?
    if @user.update_attributes(params[:user])
      flash[:notice] = "Пользователь #{@user.email} успешно обновлен"
      redirect_to [:edit, :admin, @user]
    else
      flash[:alert] = "При обновлении возникли ошибки"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Пользователь '#{@user.first_name} #{@user.last_name}' успешно удален"
    redirect_to [:admin, :users]
  end

  private
    def find_user
      @user = User.find(params[:id])
    end
end