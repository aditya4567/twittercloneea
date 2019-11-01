class TweetSerializer < ActiveModel::Serializer
  attributes :id, :body, :user
end
