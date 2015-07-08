class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :moves, dependent: :destroy

  validates :user, presence: true
  validates :game, presence: true

  after_save :publish_reload_message

  def publish_reload_message
    WebsocketRails[:players].trigger 'reload', self
  end

end
