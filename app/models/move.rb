class Move < ActiveRecord::Base
  belongs_to :user
  belongs_to :player

  after_create :publish_create_message

  def publish_create_message
    WebsocketRails[:moves].trigger 'create', self
  end
end
