require 'rails_helper'

FactoryGirl.define do
  factory :tag do
    group
    name "metatag"
    color "#656565"
  end

  factory :discussion_tag do
    discussion
    tag
  end
end

describe ::API::DiscussionTagsController, type: :controller do

  describe 'index' do
    let(:user) { create :user }
    let(:group) { create :group }
    let(:another_group) { create :group }
    let(:discussion) { create :discussion, group: group }
    let(:another_discussion) { create :discussion, group: group }
    let(:hidden_discussion) { create :discussion }

    let(:tag) { create :tag, name: "My tag", group: group }
    let(:another_tag) { create :tag, name: "Hidden tag", group: another_group }
    let!(:discussion_tag) { create :discussion_tag, tag: tag, discussion: discussion }
    let!(:another_discussion_tag) { create :discussion_tag, tag: tag, discussion: another_discussion }
    let!(:hidden_discussion_tag) { create :discussion_tag, tag: another_tag, discussion: hidden_discussion }

    before do
      sign_in user
      group.add_member! user
    end

    it 'returns a list of tags for the given discussions' do
      get :index, discussion_keys: [discussion.key, another_discussion.key, hidden_discussion.key]
      json = JSON.parse(response.body)
      tag_ids = json['discussion_tags'].map { |t| t['id'] }
      expect(tag_ids).to include discussion_tag.id
      expect(tag_ids).to include another_discussion_tag.id
      expect(tag_ids).to_not include hidden_discussion_tag.id

      tag_names = json['discussion_tags'].map { |t| t['name'] }
      expect(tag_names).to include tag.name
      expect(tag_names).to_not include another_tag.name
    end
  end

end