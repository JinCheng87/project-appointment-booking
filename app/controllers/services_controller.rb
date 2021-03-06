class ServicesController < ApplicationController
  before_action :find_service, except: [:create, :new, :index]
  before_action :authenticate_admin, except: [:show, :index]
  def index
    @services = Service.all
  end

  def new
    @service = Service.new
    render :new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to @service, notice: 'service created successfully'
    else
      render :new
    end
  end

  def show
    @is_admin = is_admin
  end

  def edit
  end

  def update
    if @service.update_attributes(service_params)
      redirect_to @service, notice: 'service updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to show_services_path, notice: 'service deleted successfully'
  end

  private

  def service_params
    params.require(:service).permit(:name, :duration, :price, :category)
  end

  def find_service
    @service = Service.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render 'errors/not_found'
  end
end