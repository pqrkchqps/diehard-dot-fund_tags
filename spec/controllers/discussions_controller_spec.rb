require 'rails_helper'

describe ::Api::DiscussionsController, type: :controller do

  let(:user) { create :user }
  let(:group) { create :group, is_visible_to_public: false }
  let(:tag) { create :tag, group: group }
  let(:discussion) { create :discussion, group: group }
  let!(:discussion_tag) { create :discussion_tag, discussion: discussion, tag: tag }
  let!(:another_discussion) { create :discussion, group: group }

  describe 'tags' do
    before { sign_in user }

    it 'returns threads associated with a tag' do
      group.add_member! user
      get :tags, params: { tag_id: tag.id }
      json = JSON.parse(response.body)

      discussion_ids = json['discussions'].map { |t| t['id'] }

      expect(discussion_ids).to include discussion.id
      expect(discussion_ids).to_not include another_discussion.id
    end

    it 'does not return a tag for a group the user is not a member of' do
      get :tags, params: { tag_id: tag.id }
      expect(response.status).to eq 403
    end
  end

end
