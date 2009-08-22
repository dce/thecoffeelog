class User < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :subscriptions
  has_many :feeds, :through => :subscriptions

  before_save :generate_access_token

  def activate!
    self.update_attribute(:active, true)
  end

  private

  def generate_access_token
    code = ""

    begin
      code = rand(36**12).to_s(36)
    end while code.length < 12 or User.find_by_access_token(code)

    self.access_token = code
  end
end
