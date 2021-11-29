# == Schema Information
#
# Table name: draws
#
#  id           :integer          not null, primary key
#  name_attempt :string
#  name_match   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  play_id      :integer
#  roster_id    :integer
#
class Draw < ApplicationRecord
end
