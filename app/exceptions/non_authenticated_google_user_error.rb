class NonAuthenticatedGoogleUserError < ApplicationError
  def errors
    { base: I18n.t("errors.google_token.invalid")}
  end
end
