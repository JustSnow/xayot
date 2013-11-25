class Admin::CitiesController < Admin::AdminController
	before_filter :find_city, except: [:index, :new, :create]

	def index
		@cities = City.order_desc.paginate(page: params[:page], per_page: 15)
	end

	def new
		@city = City.new
	end

	def create
		@city = City.new params[:city]

		if @city.save
			flash[:notice] = "Город '#{@city.name}' успешно создан"
			redirect_to [:edit, :admin, @city]
		else
			flash[:alert] = 'Ошибка создания'
			render 'new'
		end
	end

	def edit
	end

	def update
		if @city.update_attributes params[:city]
			flash[:notice] = "Город '#{@city.name}' успешно обновлен"
			redirect_to [:edit, :admin, @city]
		else
			flash[:alert] = 'Ошибка обновления'
			render 'edit'
		end
	end

	def destroy
		@city.destroy
		flash[:notice] = "Город '#{@city.name}' успешно удален"
		redirect_to [:admin, :cities]
	end

	private
		def find_city
			@city = City.find params[:id]
		end
end