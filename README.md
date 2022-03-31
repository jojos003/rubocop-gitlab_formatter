# RuboCop GitLab Formatter

A very simple [RuboCop](https://github.com/rubocop/rubocop) formatter that renders a json compliant with the [Gitlab CodeQuality format](https://docs.gitlab.com/ee/user/project/merge_requests/code_quality.html#implementing-a-custom-tool).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-gitlab_formatter', require: false
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```ruby
$ gem install rubocop-gitlab_formatter
```

## Usage

```sh
rubocop --require rubocop-gitlab_formatter --format RuboCop::Formatter::GitLabFormatter
```

Or require it in `.rubocop.yml`:

```yaml
require:
  - rubocop-gitlab_formatter
```

The main purpose of the formatter is to be used with the [GitLab code quality](https://docs.gitlab.com/ee/user/project/merge_requests/code_quality.html) report.

Configure your `.gitlab-ci.yml` like that:

```yaml
rubocop:
  artifacts:
    reports:
      codequality: codequality_reports.json
  script:
    - rubocop --require rubocop-gitlab_formatter --format RuboCop::Formatter::GitLabFormatter --out codequality_reports.json
```

And enjoy the Code Quality features :tada:

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jojos003/rubocop-gitlab_formatter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
