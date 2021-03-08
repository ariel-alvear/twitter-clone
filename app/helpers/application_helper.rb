module ApplicationHelper

    def generate_api_key
        SecureRandom.base58(24)
    end
end
