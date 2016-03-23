class Admin < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}

  ROLES = %i[系统管理员 基金负责人 产品管理 客户管理 禁用账户]

  bitmask :roles_mask, :as => [:系统管理员, :基金负责人, :产品管理, :客户管理, :禁用账户]

  def roles=(roles)
    roles = [*roles].map { |r| r.to_sym }
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    roles.include?(role)
  end
end
