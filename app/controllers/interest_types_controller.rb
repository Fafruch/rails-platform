class InterestTypesController < ApplicationController
  before_action :authenticate_organization_admin
  before_action :find_interest_type, only: %i[destroy]

  def new
    @interest_type = InterestType.new
  end

  def create
    @interest_type = InterestType.new(interest_type_params)
    if @interest_type.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def index
    @organization = Organization.find(params[:organization_id])
    @interest_types = @organization.interest_types
  end

  def update
    if @interest_types.update_attributes(interest_type_paramas)
      redirect_to action: 'index'
    else
      render :edit
    end
  end

  def destroy
    @interest_type.destroy

    redirect_to action: 'index'
  end


  private

  def authenticate_organization_admin
    render file: 'public/403.html' unless admin_role_for_organization?
  end

  def admin_role_for_organization?
    current_user.user_organizations.exists?(organization_role: 'organization_admin', organization_id: params[:organization_id])
  end

  def interest_type_params
    params.require(:interest_type).permit(:name).merge(organization_id: params[:organization_id])
  end

  def find_interest_type
    @interest_type ||= InterestType.find(params[:id])
  end
end
