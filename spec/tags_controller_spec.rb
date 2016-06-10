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

describe ::API::TagsController, type: :controller do

  let(:user) { create :user }
  let(:group) { create :group }
  let!(:tag) { create :tag, group: group }
  let!(:another_tag) { create :tag }

  describe 'index' do
    before { sign_in user }

    it 'returns tags from a particular group' do
      group.add_member! user
      get :index, group_id: group.id
      expect(response.status).to eq 200

      json = JSON.parse(response.body)
      tag_ids = json['tags'].map { |t| t['id'] }
      expect(tag_ids).to include tag.id
      expect(tag_ids).to_not include another_tag.id
    end

    it 'does not return tags from groups the user does not have access to' do
      get :index, group_id: group.id
      expect(response.status).to eq 200

      json = JSON.parse(response.body)
      tag_ids = json['tags'].map { |t| t['id'] }
      expect(tag_ids).to_not include tag.id
      expect(tag_ids).to_not include another_tag.id
    end

    it 'requires a group id' do
      expect { get :index }.to raise_error { ActiveRecord::RecordNotFound }
    end
  end

end
