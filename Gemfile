ruby "2.6.3"
source 'https://rubygems.org'
# git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails',                '5.2.2' 
gem 'bcrypt',               '3.1.7'
gem 'faker',                '1.4.2'
gem 'bootstrap-sass', '~> 3.4.1'
gem 'sass-rails',           '6.0.0'#'5.0.2' #6.0.0
#gem 'sass-rails', '~> 5.0'
gem 'uglifier',             '2.5.3'
#gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails',         '4.2.2'#'4.0.3'
gem 'coffee-rails', '~> 4.2'
#gem 'coffee-rails',         '4.0.1'#'4.1.0' # platforms: :ruby # 4.1.1
gem 'turbolinks', '~> 5'
#gem 'turbolinks',           '>5.2.0'#'2.3.0' # 2.5.3 # RUNTIME DEPENDENCIES (1): coffee-rails >= 0
gem 'jbuilder',             '2.10.1'#'2.2.3' # '~> 2.0' # (>= 3.0.0, < 5) #'2.7.0'
#gem 'jbuilder', '~> 2.5'
gem 'sdoc',                 '0.4.0', group: :doc
gem 'jquery-ui-rails',      '6.0.1'#'~> 5.0', '>=5.0.5'#'~> 5.0', '>=5.0.5' # 6.0.1
gem 'acts_as_list',         '1.0.2' #(0.9.19)
#gem 'rails-controller-testing',
#gem 'activemodel-serializers-xml',
#gem 'record_tag_helper', '~> 1.0'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'sqlite3',     '1.3.9'
  gem 'byebug',      '3.4.0'# gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'web-console', '3.1.1'#'2.0.0.beta3' # 3.7.0
  #gem 'web-console', '>= 3.3.0'
  #gem 'listen', '>= 3.0.5', '< 3.2'
  #gem 'spring',      '1.1.3'
  #gem 'spring'
  #gem 'spring-watcher-listen', '~> 2.0.0'
end
group :test do
  gem 'minitest-reporters', '1.0.5'
  # gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
end
group :production do
  gem 'pg',   '~> 0.18'
  gem 'rails_12factor', '0.0.2'
  gem 'puma', '~> 4.3'
end
