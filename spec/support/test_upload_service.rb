# frozen_string_literal: true

# License: AGPL-3.0-or-later WITH Web-Template-Output-Additional-Permission-3.0-or-later
require 'stringio'
class TestUploadService < ActiveStorage::Service
  TEST_ERROR_MESSAGE = 'test exception thrown'

  attr_reader :output, :options
  def clear
    @output = nil
    @raise_error = false
    @options = nil
  end

  # use this to throw an exception instead of finishing
  def raise_error
    @raise_error = true
  end

  def upload(key, io, checksum:nil, **options)
    @options = options

    @output = io.read
    raise TEST_ERROR_MESSAGE if @raise_error
  end

  def url(key, **options)
    "http://fake.url/#{key}"
  end
end
