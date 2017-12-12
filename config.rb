###
# Page options, layouts, aliases and proxies
###

require 'tzinfo'
Time.zone = 'America/Los_Angeles'
Haml::TempleEngine.disable_option_validator!

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

set :haml, { ugly: true, format: :html5 }

activate :i18n, templates_dir: 'views'
set :layouts_dir, 'views/layouts'

# Webpack asset pipeline
activate :external_pipeline,
         name: :webpack,
         command: build? ? 'NODE_ENV=production ./node_modules/webpack/bin/webpack.js --bail -p' : './node_modules/webpack/bin/webpack.js --watch -d --progress --color',
         source: '.tmp/dist',
         latency: 1

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'


# With alternative layout
# page '/path/to/file.html', layout: :otherlayout

# With alternative layout
# page '/path/to/file.html', layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy '/this-page-has-no-template.html', '/template-file.html', locals: {
#  which_fake_page: 'Rendering a fake page with a local variable' }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :blog do |blog|
  blog.sources = 'projects/:title.html'
  blog.permalink = 'projects/{title}.html'

  blog.default_extension = '.haml'
  blog.layout = 'project'
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = 'page/{num}'
end

activate :directory_indexes

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
configure :build do
  # Ignore asset building so Webpack has control
  ignore { |path| path =~ /\/(.*)\.js|scss$/ }

  # Hash assets
  activate :asset_hash do |a|
    a.ignore = [/\/(.*)\.woff|woff2$/, /sw.js/]
  end

  # Zip it
  activate :gzip

  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Minify HTML on build
  activate :minify_html
end
