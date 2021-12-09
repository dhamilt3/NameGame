# == Schema Information
#
# Table name: plays
#
#  id            :integer          not null, primary key
#  correct_sum   :string
#  incorrect_sum :string
#  percent       :float
#  user_play     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#
class Play < ApplicationRecord
end
