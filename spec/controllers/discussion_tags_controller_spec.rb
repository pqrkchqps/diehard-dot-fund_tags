require 'rails_helper'

describe ::API::DiscussionTagsController, type: :controller do

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

  let(:discussion_tag_params) {{
    tag_id: tag.id,
    discussion_id: discussion.id
  }}

  before { sign_in user }

  describe 'index' do
    before { group.add_member! user }

    it 'returns a list of tags for the given discussions' do
      get :index, group_keys: [group.key, another_group.key].join(',')
      json = JSON.parse(response.body)
      discussion_tag_ids = json['discussion_tags'].map { |t| t['id'] }
      expect(discussion_tag_ids).to include discussion_tag.id
      expect(discussion_tag_ids).to include another_discussion_tag.id
      expect(discussion_tag_ids).to_not include hidden_discussion_tag.id

      tag_names = json['tags'].map { |t| t['name'] }
      expect(tag_names).to include tag.name
      expect(tag_names).to_not include another_tag.name
    end
  end

  describe 'create' do
    it 'can create a tag' do
      group.add_member! user
      expect { post :create, discussion_tag: discussion_tag_params }.to change { DiscussionTag.count }.by(1)

      json = JSON.parse(response.body)
      expect(json['discussion_tags'][0]['tag_id']).to eq tag.id
      expect(json['discussion_tags'][0]['discussion_id']).to eq discussion.id
    end

    it 'cannot create a tag in a discussion the user does not have access to' do
      expect { post :create, discussion_tag: discussion_tag_params }.to_not change { DiscussionTag.count }
      expect(response.status).to eq 403
    end
  end

  describe 'destroy' do
    it 'can destroy a tag' do
      group.add_member! user
      expect { delete :destroy, id: discussion_tag.id }.to change { DiscussionTag.count }.by(-1)
      expect(response.status).to eq 200
    end

    it 'does not allow destroying tags the user does not have access to' do
      expect { delete :destroy, id: discussion_tag.id }.to_not change { DiscussionTag.count }
      expect(response.status).to eq 403
    end
  end

end
