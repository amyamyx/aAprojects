# == Schema Information
#
# Table name: taggings
#
#  id               :bigint           not null, primary key
#  tag_topic_id     :integer
#  shortened_url_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
