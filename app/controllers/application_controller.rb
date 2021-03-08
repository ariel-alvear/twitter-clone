class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def set_user_by_token(mapping = nil)
        api_key = request.headers[:HTTP_X_API_KEY]

        if api_key.nil?
            super mapping
        else
            user = User.find_by_api_key(api_key)
            if account_member.nil?
                super mapping
            else
                user = user.user
            unless user.current_account.id == user.account.id
                user.current_account = user.account
                user.save
            end

            sign_in(:user, user)
            rc = resource_class(mapping)
            scope = rc.to_s.underscore.to_sym
            bypass_sign_in(user, scope: scope)
            return user
            end
        end
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo_url])
    end
end
