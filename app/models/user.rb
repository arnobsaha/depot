class User < ActiveRecord::Base
  # Ensure that after destroy at least it will rollback and load all users
  after_destroy :ensure_an_admin_remains

  #The key concept here is the use of an exception to indicate an error when delet-
  #ing the user. This exception serves two purposes.

  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end

  #attr_accessible :hashed_password, :name, :salt
  # This method is a shortcut to all default validators and any custom
  # validator classes ending in 'Validator'. Note that Rails default
  # validators can be overridden inside specific classes by creating
  # custom validator classes in their place such as PresenceValidator.

  # *** Very very Important : Specifies a white list of model attributes that can be set via
  # mass-assignment.
  attr_accessible :name,:password,:password_confirmation

  attr_accessor :password_confirmation
  attr_reader :password
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  # Validates each attribute against a block. validate is used to use custom block used also
  validate :password_must_be_present

  def User.authenticate(name, password)
    if user = find_by_name(name)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end

  # 'password' is a virtual attribute
  def password=(password)
    @password = password
    if password.present?
      # If password is not present then generate salt
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  private
  # Check the password match or miss match
  def password_must_be_present
    errors.add(:password, "Missing password") unless hashed_password.present?
  end

  # This function is used to generate the salt by using self object random id
  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
