# frozen_string_literal: true

# License: AGPL-3.0-or-later WITH Web-Template-Output-Additional-Permission-3.0-or-later
module CreatePeerToPeerCampaign
  def self.create(campaign_params, profile_id)
    begin
      parent_campaign = Campaign.find(campaign_params[:parent_campaign_id])
    rescue ActiveRecord::RecordNotFound
      return { errors: { parent_campaign_id: 'not found' } }.as_json
    end

    p2p_params = campaign_params.except(:nonprofit_id, :summary, :goal_amount)
    p2p_params.merge!(parent_campaign.child_params)

    profile = Profile.find(profile_id)
    base_slug = Format::Url.convert_to_slug "#{p2p_params[:name]}-#{profile.name}"
    algo = SlugP2pCampaignNamingAlgorithm.new(p2p_params[:nonprofit_id])
    p2p_params[:slug] = algo.create_copy_name(base_slug)

    campaign = Campaign.create(p2p_params)

    campaign.published = true
    campaign.profile = profile
    campaign.save
    campaign.main_image.attach(parent_campaign.main_image.blob) if parent_campaign.main_image.attached?

    campaign.background_image.attach(parent_campaign.background_image.blob) if parent_campaign.background_image.attached?


    campaign.banner_image.attach(parent_campaign.banner_image.blob) if parent_campaign.banner_image.attached?


    campaign
  end
end
