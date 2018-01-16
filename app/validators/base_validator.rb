class BaseValidator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def validate!(user_params)
    user_params.each do |k,v|
      begin
        self.send("#{k}=",v)
      rescue NameError; end
    end

    raise ActiveRecord::RecordInvalid.new(self) unless valid?
  end
end
