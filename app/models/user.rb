class User < ActiveRecord::Base
  as_enum :gender, male: 0, female: 1
  after_initialize :set_default_gender, :if => :new_record?

  def set_default_gender
  	self.gender ||= :male
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :name, :email, :login, :gender, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  # ASSOCIATIONS
  has_many :cars

  # VALIDATIONS
  validates_presence_of :password, on: :create
  validates_length_of :password, minimum: 8, if: :password
  validates_confirmation_of :password, if: :password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  validates :login, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]+\Z/ },
               length: { minimum:1, maximum: 30 }
  validates :name, presence: true, length: {minimum: 1, maximum: 30}



end
