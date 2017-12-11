class InterestsController < ApplicationController
  before_action :authenticate_organization_admin
  before_action :find_user_organization


  def new
    @interest = Interest.new
    @interest_types = Organization.find(params[:organization_id]).interest_types
    @interest_types_hash = Hash[@interest_types.map { |interest_type| [interest_type.name, interest_type.id] }]
  end

  def create
    @interest = Interest.new(interest_params)
    if @interest.save
      redirect_to action: 'index'
    else
      @interest_types = Organization.find(params[:organization_id]).interest_types
      @interest_types_hash = Hash[@interest_types.map { |interest_type| [interest_type.name, interest_type.id] }]
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @interests = @user_organization.interests
  end


  private

  def authenticate_organization_admin
    render file: 'public/403.html' unless admin_role_for_organization? || params[:user_id] != current_user.id
  end

  def admin_role_for_organization?
    current_user.user_organizations.exists?(organization_role: 'organization_admin', organization_id: params[:organization_id])
  end

  def interest_params
    params.require(:interest).permit(:name, :interest_type_id).merge(user_organization_id: @user_organization.id)
  end

  def find_user_organization
    @user_organization ||= UserOrganization.find_by(organization_id: params[:organization_id], user_id: params[:user_id])
  end
end
