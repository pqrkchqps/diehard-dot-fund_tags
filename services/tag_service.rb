class TagService
  def self.create(tag:, actor:)
    actor.ability.authorize! :create, tag

    return false unless tag.valid?
    tag.save!
    EventBus.broadcast 'tag_create', tag, actor
  end

  def self.destroy(tag:, actor:)
    actor.ability.authorize! :destroy, tag

    tag.destroy
    EventBus.broadcast 'tag_destroy', tag, actor
  end
end
