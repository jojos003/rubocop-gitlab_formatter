# frozen_string_literal: true

require 'rubocop'
require 'rubocop/formatter/base_formatter'

module RuboCop
  module Formatter
    class GitLabFormatter < BaseFormatter
      include PathUtil

      SEVERITY_MAPPING = {
        I: 'info',
        R: 'minor',
        C: 'minor',
        W: 'major',
        E: 'critical',
        F: 'blocker'
      }.freeze

      def initialize(output, options = {})
        super

        @output_json = []
      end

      def file_finished(file, offenses)
        offenses.each do |offense|
          @output_json << build_offense(file, offense)
        end
      end

      def finished(_inspected_files)
        output.write @output_json.to_json
      end

      private

      def build_offense(file, offense)
        {
          description: offense.message,
          fingerprint: offense.hash,
          severity: SEVERITY_MAPPING[offense.severity.code.to_sym],
          location: {
            path: smart_path(file),
            lines: {
              begin: offense.location.line
            }
          }
        }
      end
    end
  end
end
