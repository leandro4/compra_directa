ActiveAdmin.register Product do
  belongs_to :provider

  actions :index, :new, :create, :edit, :update, :destroy

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name, :description, :price, :is_discount, :discount_price, :discount_expire_at

  config.clear_action_items!

  action_item :only => :index do
    link_to "New Product" , new_admin_provider_product_path
  end

  scope("All Products", :all, default: true)
  scope("All Discounts") { |scope| scope.where(is_discount: true) }
  scope("Active Discounts") { |scope| scope.active_discount }
  scope("Expired Discounts") { |scope| scope.expired_discount }

  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :name
  filter :description
  filter :price
  filter :is_discount
  filter :discount_price
  filter :discount_expire_at

  index title: proc{ "#{@provider.business_name}'s Products" } do
    column :name
    column :description do |product|
      truncate(product.description, omision: "...", length: 30)
    end

    column :price
    column :is_discount
    column :discount_price
    column :discount_expire_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :is_discount
      f.input :discount_price
      f.input :discount_expire_at, as: :datepicker, datepicker_options: {min_date: Time.zone.today }
    end
    f.actions
  end

  # controller do
  #   def destroy
  #     parent.products.find(params[:id]).soft_delete!
  #     redirect_to admin_provider_products_path(notice: "Product deleted")
  #   end
  # end
end
