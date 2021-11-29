# == Schema Information
#
# Table name: plays
#
#  id            :integer          not null, primary key
#  correct_sum   :string
#  draws_count   :integer
#  incorrect_sum :string
#  result        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#
class Play < ApplicationRecord
end
