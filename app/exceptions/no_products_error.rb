class NoProductsError < ApplicationError
  def errors
    { base: I18n.t("errors.messages.no_products")}
  end
end
