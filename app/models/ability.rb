# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Post, QuickTweet], draft: false
    can :read, Comment

    return unless user.present?
    can [:read, :update, :new, :create, :destroy], [Post, QuickTweet], user: user
    can [:read, :update, :new, :create, :destroy], Comment, user: user
  end
end
