require 'cognito_jwt_keys'
require 'cognito_urls'

if !ENV['AWS_COGNITO_DOMAIN'].blank?
  CognitoUrls.init(ENV['AWS_COGNITO_DOMAIN'],
                   ENV['AWS_COGNITO_REGION'])

  CognitoJwtKeysProvider.init(ENV['AWS_COGNITO_POOL_ID'])
else
  puts "Skipping Cognito initialization"
end
