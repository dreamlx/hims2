json.user do
  json.(@user, :id, :cell, :open_id, :name, :email)
  json.id_type @user.id_type if @user.id_type
  json.nickname @user.nickname if @user.nickname
  json.gender @user.gender if @user.gender
  json.address @user.address if @user.address
  json.card_type @user.card_type if @user.card_type
  json.card_no @user.card_no if @user.card_no
  json.card_front @user.card_front if @user.card_front
  json.card_back @user.card_back if @user.card_back
  json.remark @user.remark if @user.remark
end