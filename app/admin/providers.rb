ActiveAdmin.register Provider do
  actions :index, :edit, :update, :destroy
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :business_name, :category, :description, :email, :cuit, :address, :city, :phone, :iva

  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :business_name
  filter :email
  filter :cuit
  filter :address
  filter :city

  index do
    column :business_name
    column :description do |provider|
      truncate(provider.description, omision: "...", length: 20)
    end

    column :category do |provider|
      Category.all[provider.category]
    end
    column :email
    column :cuit
    column :address
    column :city
    column :phone
    column :iva
    actions do |provider|
      item "Products", admin_provider_products_path(provider), class: "member_link"
    end
  end

  form do |f|
    f.inputs do
      f.input :business_name
      f.input :description
      f.input :category, as: :select, collection: Category.all.map { |c| [c[1], c[0]]}
      f.input :email
      f.input :cuit
      f.input :address
      f.input :city
      f.input :phone
      f.input :iva
    end
    f.actions
  end
end
