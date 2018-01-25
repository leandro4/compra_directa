require 'fcm'

class Notifier

  def order_requested_push(order)
    options = {data: {title: "Has recibido un nuevo pedido", body: "El comercio #{order.commerce.business_name} te ha encargado #{order.order_items.count} #{"producto".pluralize(order.order_items.count)}", id: order.id, action: "order"}}

    push(order.provider.api_token.registration_id, options) if order.provider.api_token
  end

  def order_accepted_push(order)
    options = {data: {title: "Pedido aceptado", body: "El proveedor #{order.provider.business_name} ha aceptado tu pedido de #{order.order_items.count} #{"producto".pluralize(order.order_items.count)}", id: order.id, action: "order"}}

    push(order.commerce.api_token.registration_id, options) if order.commerce.api_token
  end

  def order_rejected_push(order)
    options = {data: {title: "Pedido rechazado", body: "El proveedor #{order.provider.business_name} ha rechazado tu pedido de #{order.order_items.count} #{"producto".pluralize(order.order_items.count)}", id: order.id, action: "order"}}

    push(order.commerce.api_token.registration_id, options) if order.commerce.api_token
  end

  def new_question_push(question)
    options = {data: {title: "Te han hecho una pregunta", body: "El comercio #{question.commerce.business_name} te ha hecho una pregunta en tu producto #{question.product.name}", id: question.product.id, action: "product"}}

    push(question.provider.api_token.registration_id, options) if question.provider.api_token
  end

  def question_answered_push(question)
    options = {data: {title: "Te han respondido una pregunta", body: "El proveedor #{question.provider.business_name} te ha respondido una pregunta por el producto #{question.product.name}", id: question.product.id, action: "product"}}

    push(question.commerce.api_token.registration_id, options) if question.commerce.api_token
  end

  protected

  def push(notificacion_id, options)

    fcm = FCM.new(APP_CONFIG["firebase_api_key"])

    response = fcm.send([notificacion_id], options)
  end
end
