# == Schema Information
#
# Table name: draws
#
#  id           :integer          not null, primary key
#  draw_count   :integer
#  draw_result  :integer
#  draw_total   :integer
#  name_attempt :string
#  name_match   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  play_id      :integer
#  roster_id    :integer
#
class Draw < ApplicationRecord
end
