class AdminMailer < ApplicationMailer
  default from: APP_CONFIG["admin_email"]

  def new_order(order)
    @order = order

    mail(to: APP_CONFIG["admin_email"], subject: "Nuevo pedido")
  end
end
