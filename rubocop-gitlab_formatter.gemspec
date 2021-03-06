# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'rubocop-gitlab_formatter'
  spec.version = '0.1.0'
  spec.authors = ['Jonathan Georges']
  spec.email = ['jojos003@free.fr']

  spec.summary = 'A RuboCop formatter for GitLab CodeQuality reports'
  spec.description = 'A very simple RuboCop formatter that renders a json compliant with the Gitlab CodeQuality format.'
  spec.homepage = 'https://github.com/jojos003/rubocop-gitlab_formatter'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = `git ls-files lib LICENSE.txt README.md`.split($RS)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rubocop', '~> 1.0'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.9'
end
