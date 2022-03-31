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

      attr_reader :output_array

      def initialize(output, options = {})
        super

        @output_array = []
      end

      def file_finished(file, offenses)
        offenses.each do |offense|
          output_array << hash_for_offense(file, offense)
        end
      end

      def finished(_inspected_files)
        output.write output_array.to_json
      end

      def hash_for_offense(file, offense)
        {
          description: offense.message,
          fingerprint: offense.hash,
          severity: SEVERITY_MAPPING[offense.severity.code.to_sym],
          location: hash_for_location(file, offense.location)
        }
      end

      def hash_for_location(file, location)
        {
          path: smart_path(file),
          lines: {
            begin: location.line
          }
        }
      end
    end
  end
end
