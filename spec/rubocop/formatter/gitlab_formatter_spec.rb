# frozen_string_literal: true

RSpec.describe RuboCop::Formatter::GitLabFormatter do
  subject(:formatter) { described_class.new(output) }

  let(:output) { StringIO.new }

  let(:files) { %w[/path/to/file1 /path/to/file2] }
  let(:file) { files[0] }
  let(:location) do
    source_buffer = Parser::Source::Buffer.new('test', 1)
    source_buffer.source = %w[a b cdefghi].join("\n")
    Parser::Source::Range.new(source_buffer, 2, 10)
  end
  let(:offense) do
    RuboCop::Cop::Offense.new(:convention, location, 'This is message', 'CopName', :corrected)
  end

  describe '#file_finished' do
    subject(:file_finished) { formatter.file_finished(file, offenses) }

    let(:output_array) { formatter.output_array }
    let(:offenses) do
      [
        instance_double('RuboCop::Cop::Offense'),
        instance_double('RuboCop::Cop::Offense')
      ]
    end

    before do
      allow(formatter).to receive(:hash_for_offense) { {} }
    end

    it 'adds offenses to #output_array' do
      expect { file_finished }
        .to change { output_array.count }
        .from(0).to(2)
    end
  end

  describe '#finished' do
    before do
      formatter.file_finished(file, [offense])
    end

    it 'outputs #output_array as JSON' do
      formatter.finished(files)
      json = output.string
      restored_array = JSON.parse(json, symbolize_names: true)
      expect(restored_array).to eq(formatter.output_array)
    end
  end

  describe '#hash_for_offense' do
    subject(:hash) { formatter.hash_for_offense(file, offense) }

    it 'sets description' do
      expect(hash[:description]).to eq 'This is message'
    end

    it 'sets fingerprint' do
      expect(hash[:fingerprint]).to eq offense.hash
    end

    it 'sets severity' do
      expect(hash[:severity]).to eq 'minor'
    end

    it 'sets location' do
      location_hash = formatter.hash_for_location(file, offense.location)
      expect(hash[:location]).to eq location_hash
    end
  end

  describe '#hash_for_location' do
    subject(:hash) { formatter.hash_for_location(file, offense) }

    let(:file) { File.expand_path('path/to/file1') }

    it 'sets path' do
      expect(hash[:path]).to eq 'path/to/file1'
    end

    it 'sets lines' do
      expect(hash[:lines]).to include(begin: 2)
    end
  end
end
