ActiveAdmin.register Order do
  belongs_to :provider

  actions :index

  scope("Pending", default: true) { |scope| scope.where(status: Order::PENDING )}
  scope("Accepted") { |scope| scope.where(status: Order::ACCEPTED )}
  scope("Rejected") { |scope| scope.where(status: Order::REJECTED )}

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index title: proc{ "#{@provider.business_name}'s Orders" } do
    column :status do |order|
      span order.status, class: "status_tag no"
    end
    column :commerce do |order|
      order.commerce.business_name
    end
    column :products do |order|
      span order.order_items.count, class: "status_tag no"
    end
  end
end
