ActiveAdmin.register_page "Sales" do
  content do
    date = Date.new(* %w(1 2 3).map { |e| params[:sales]["date(#{e}i)"].to_i }) if params[:sales]
    date ||= Time.zone.now.beginning_of_month

    providers = Provider.includes(:orders).where("orders.accepted_at >= ? AND orders.accepted_at <= ?", date.beginning_of_month, date.end_of_month).references(:orders)

    render partial: 'index', locals: { providers: providers }
  end

  sidebar :filter do
    date = Date.new(* %w(1 2 3).map { |e| params[:sales]["date(#{e}i)"].to_i }) if params[:sales]
    date ||= Time.zone.now.beginning_of_month

    render partial: 'filter', locals: { date: date }
  end
end
