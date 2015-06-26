class Car < ActiveRecord::Base
  attr_accessible :color, :horsepower, :name, :user

  # ASSOCIATIONS
  belongs_to :user

  # SCOPES
  scope :owned_by_user, -> (user) { includes(:user).
                                where("users.id = ?", user.id)}

  scope :owned_by_female, -> {includes(:user).
                              where("users.gender_cd = ?", 1)}
end
