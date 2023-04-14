# == Schema Information
#
# Table name: collars
#
# *id*::             <tt>uuid, not null, primary key</tt>
# *last_latitude*::  <tt>string</tt>
# *last_longitude*:: <tt>string</tt>
# *name*::           <tt>string</tt>
# *created_at*::     <tt>datetime, not null</tt>
# *updated_at*::     <tt>datetime, not null</tt>
# *user_id*::        <tt>uuid, indexed</tt>
#
# Indexes
#
#  index_collars_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
class Collar < ApplicationRecord
  belongs_to :user
end
