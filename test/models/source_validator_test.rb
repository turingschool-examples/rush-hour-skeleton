require './test/test_helper'

class SourceValidatorTest < Minitest::Test
  def test_source_validator_excludes_sources_with_missing_identifiers
    sources = TrafficSpy::Source
    source_one = sources.create({root_url: "http://jumpstartlab.com"})

    refute sources.all.include?(source_one)
  end

  def test_source_validator_excludes_sources_with_missing_root_urls
    sources = TrafficSpy::Source
    source_one = sources.create({identifier: "jumpstartlab"})

    refute sources.all.include?(source_one)
  end

  def test_source_validator_excludes_sources_with_duplicate_identifiers
    sources = TrafficSpy::Source
    source_one = sources.create({identifier: "jumpstartlab",
                                 root_url: "http://jumpstartlab.com"})
    source_two = sources.create({identifier: "jumpstartlab",
                                 root_url: "http://jumpstartlab.com"})

    assert sources.all.include?(source_one)
    refute sources.all.include?(source_two)
  end
end
