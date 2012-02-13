module Devise
  module Models
    module Authenticatable
      module Shim
        extend ActiveSupport::Concern

        module ClassMethods

          protected

          # Generate a token by looping and ensuring does not already exist.
          def generate_token(column)
            loop do
              token = Devise.friendly_token
              break token unless view(:"by_#{column}", :key => token, :limit => 1).any?
            end
          end
        end
      end
    end
  end
end
