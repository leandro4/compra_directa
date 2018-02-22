ActiveAdmin.register Order do
  belongs_to :provider

  actions :index, :show

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

  breadcrumb do
    if params[:action] == 'show'
    [link_to("Admin", admin_root_path),
     link_to("Sales", admin_sales_path),
     link_to(provider.business_name, admin_provider_sales_detail_path(provider, date: params[:date]))
    ]
    else
    [link_to("Admin", admin_root_path),
     link_to("Providers", admin_providers_path),
     provider.business_name
    ]
    end
  end

  filter :commerce

  index title: proc{ "#{@provider.business_name}'s Orders" } do
    column :commerce do |order|
      order.commerce.business_name
    end
    column :status do |order|
      span order.status, class: "status_tag no"
    end
    column :products do |order|
      span order.order_items.count, class: "status_tag no"
    end
    column :created_at
  end

  show do
    attributes_table do
      table_for order.order_items do
        column :name do |order_item|
          order_item.product_name
        end
        column :description do |order_item|
          order_item.product_description
        end

        column :unit_price
        column :quantity
      end

      row :total_price do
        order.total_price
      end
      row :total_quantity do
        order.order_items.count
      end
    end
  end
end
