ActiveAdmin.register_page "Sales" do
  content do
    date = Date.new(* %w(1 2 3).map { |e| params[:sales]["date(#{e}i)"].to_i }) if params[:sales]
    date ||= Time.zone.now.beginning_of_month

    orders = Order.where("accepted_at >= ? AND accepted_at <= ?", date.beginning_of_month, date.end_of_month)

    providers = orders.collect(&:provider).uniq

    render partial: 'index', locals: { providers: providers, orders: orders }
  end

  sidebar :filter do
    date = Date.new(* %w(1 2 3).map { |e| params[:sales]["date(#{e}i)"].to_i }) if params[:sales]
    date ||= Time.zone.now.beginning_of_month

    render partial: 'filter', locals: { date: date }
  end
end
