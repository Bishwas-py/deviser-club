# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :pagy_index], [Post, QuickTweet], is_published: true

    can :read, Comment, is_trashed: false
    can :read, Bookmark

    return unless user.present?
    can [:read, :update, :new, :create, :destroy], [Post, QuickTweet], user: user
    can [:read, :update, :new, :create, :destroy, :form, :trash], Comment, user: user
  end
end
