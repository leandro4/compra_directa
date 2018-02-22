ActiveAdmin.register_page "Sales Detail" do
  belongs_to :provider

  breadcrumb do
    [link_to("Admin", admin_root_path),
     link_to("Sales", admin_sales_path)]
  end

  navigation_menu :default
  menu false

  content :title => proc {|user| "#{parent.business_name}'s Sales in #{t("date.month_names")[Date.parse(params[:date]).month]}" } do
    date = Date.parse(params[:date])
    provider = Provider.find(params[:provider_id])
    orders = provider.orders.where("orders.accepted_at >= ? AND orders.accepted_at <= ?", date.beginning_of_month, date.end_of_month)
    render partial: 'index', locals: { provider: provider, orders: orders, date: date }
  end
end
