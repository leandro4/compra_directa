ActiveAdmin.register Order do
  belongs_to :provider

  actions :index

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

  filter :status

  index title: proc{ "#{@provider.business_name}'s Products" } do
    column :status
    column :commerce do |order|
      order.commerce.business_name
    end
    column :products do |order|
      order.order_items.count
    end
  end
end
