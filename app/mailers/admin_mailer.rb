class AdminMailer < ApplicationMailer
  default from: ENV["ADMIN_EMAIL"]

  def new_order(order)
    @order = order

    mail(to: ENV["ADMIN_EMAIL"], subject: "Nuevo pedido")
  end
end
