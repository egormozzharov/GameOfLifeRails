class User < ActiveRecord::Base
  # after_initialize  :set_default_theme

  TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,  :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

   validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

   # validates :password, length: { in: 5..20 }
   # validates :password, :presence => true
   # validates :lol, length: { in: 5..20 }
   validates :email, :presence => true
   validates :name, :presence => true

  # after_initialize do
  #     if self.new_record?
  #         binding.pry
  #         # values will be available for new record forms.
  #         self.theme
  #     end
  # end
  #
  # def set_default_theme
  #     # здесь исправить чтобы высасывало из базы
  #     binding.pry
  #     if self.new_record?
  #         self.theme = 'light'
  #     end
  #     # self.theme_id
  #     # self.color_scheme ||= ColorScheme.where(scheme: "Light").first if self.new_record?
  # end

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # binding.pry
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user
    # binding.pry
    if user.nil?

      # Get the existing user from email if the OAuth provider gives us an email
      user = User.where(:email => auth.info.email).first if auth.info.email
      # binding.pry
      # Create the user if it is a new registration
      if user.nil?
        # binding.pry
        user = User.new(
            # name: auth.extra.raw_info.name,
            name: auth.info.name,
            #username: auth.info.nickname || auth.uid,
            email: auth.info.email.blank? ? TEMP_EMAIL : auth.info.email,
            password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end

      # Associate the identity with the user if not already
      if identity.user != user
        identity.user = user
        identity.save!
      end
    end
    user
  end

    def theme

    end
end
