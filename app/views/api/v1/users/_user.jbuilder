json.(user, :id, :business_name, :description, :email, :phone, :address, :city,
  :iva, :cuit)

json.type user.type ? user.type.downcase : nil
