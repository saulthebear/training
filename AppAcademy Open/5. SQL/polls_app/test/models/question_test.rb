# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
