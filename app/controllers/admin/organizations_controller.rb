class Admin::OrganizationsController < Admin::BaseController
  before_action :authenticate_global_admin, only: [:index]
  before_action :find_organization, only: %i[edit update destroy show]

  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to action: 'index'
    else
      render :new
    end
  end

  def update
    if @organization.update_attributes(organization_params)
      redirect_to action: 'index'
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to action: 'index'
  end


  private

  def organization_params
    params.require(:organization).permit(:name, :subdomain)
  end

  def find_organization
    @organization = Organization.find(params[:id])
  end
end
