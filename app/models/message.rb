class Message < ActiveRecord::Base
  belongs_to :user
  # I decided that Messages should belong to users rather than players so that
  # anyone can comment on any game - regardless of whether they are playing it
  # or not.

  belongs_to :game

  validates :user, presence: true
  validates :game, presence: true

  after_save :publish_reload_message
  after_destroy :publish_reload_message

  def publish_reload_message
    WebsocketRails[:chat].trigger 'reload', self
  end
end
