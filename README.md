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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jojos003/rubocop-gitlab_formatter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
