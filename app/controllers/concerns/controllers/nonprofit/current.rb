# frozen_string_literal: true

# License: AGPL-3.0-or-later WITH Web-Template-Output-Additional-Permission-3.0-or-later
module Controllers::Nonprofit::Current
    extend ActiveSupport::Concern
    included do
        helper_method :current_nonprofit_user? 

        def current_nonprofit
            @nonprofit = current_nonprofit_without_exception
            raise ActionController::RoutingError, 'Nonprofit not found' if @nonprofit.nil?

            @nonprofit
        end

        def current_nonprofit_without_exception
            key = "current_nonprofit_#{current_user_id}_params_#{[params[:state_code], params[:city], params[:name], params[:nonprofit_id], params[:id]].join('_')}"
            FetchNonprofit.with_params params, administered_nonprofit
        end
    end
end