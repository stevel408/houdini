# frozen_string_literal: true

# License: AGPL-3.0-or-later WITH Web-Template-Output-Additional-Permission-3.0-or-later
class FullContactTopic < ApplicationRecord
  # :provider,
  # :value,
  # :full_contact_info_id, :full_contact_info

  belongs_to :full_contact_info
end
