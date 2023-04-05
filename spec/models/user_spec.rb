# == Schema Information
#
# Table name: users
#
# *id*::                    <tt>bigint, not null, primary key</tt>
# *avatar*::                <tt>string</tt>
# *email*::                 <tt>string(200), not null, indexed</tt>
# *first_name*::            <tt>string(100), not null</tt>
# *last_name*::             <tt>string(100), not null</tt>
# *password_digest*::       <tt>string, not null</tt>
# *password_reset_token*::  <tt>string</tt>
# *password_token_expiry*:: <tt>datetime</tt>
# *phone*::                 <tt>string</tt>
# *status*::                <tt>integer, default("active"), not null</tt>
# *user_type*::             <tt>string(100), not null</tt>
# *created_at*::            <tt>datetime, not null</tt>
# *updated_at*::            <tt>datetime, not null</tt>
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#--
# == Schema Information End
#++

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user, :admin, permissions: [permission]) }

  let(:permission) { create(:permission, resource: :user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { is_expected.to validate_presence_of(:user_type) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  it { expect(user.permissions).not_to be_empty}

end

