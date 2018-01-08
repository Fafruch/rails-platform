class Admin::UserOrganizationsController < Admin::BaseController
  before_action :find_user

  def new
    @user_organization = UserOrganization.new
    @not_user_organizations = Organization.all - @user.organizations
    @not_user_organizations_for_select = Hash[@not_user_organizations.map { |organization| [organization.name, organization.id] }]
  end

  def create
    @user_organization = UserOrganization.new(user_organization_params)

    if @user_organization.save
      redirect_to edit_admin_user_path(@user)
    else
      render :new
    end
  end

  def destroy
    @user_organization = UserOrganization.find_by(user_id: params[:user_id], organization_id: params[:id])
    @user_organization.destroy

    redirect_to edit_admin_user_path(@user)
  end

  private

  def user_organization_params
    params.require(:user_organization).permit(:organization_id).merge(user_id: @user.id)
  end

  def find_user
    @user ||= User.find(params[:user_id])
  end
end
