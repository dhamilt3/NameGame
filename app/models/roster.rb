# == Schema Information
#
# Table name: rosters
#
#  id             :integer          not null, primary key
#  badge_number   :integer
#  department     :string
#  draws_count    :integer
#  first_name     :string
#  image          :string
#  last_name      :string
#  preferred_name :string
#  role           :string
#  shift          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Roster < ApplicationRecord
end
