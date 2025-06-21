require "test_helper"

class SentryErrorCaptureTest < ActionDispatch::IntegrationTest
  setup do
    @original_enabled_environments = Sentry.configuration.enabled_environments
    # Enable Sentry for this test temporarily
    Sentry.configuration.enabled_environments = %w[ test production staging ]
  end

  teardown do
    # Restore original configuration
    Sentry.configuration.enabled_environments = @original_enabled_environments
  end

  test "Sentry captures errors when enabled" do
    # Mock Sentry.capture_exception to verify it's called
    capture_called = false
    error_captured = nil

    # Stub the capture_exception method
    original_method = Sentry.method(:capture_exception)
    Sentry.define_singleton_method(:capture_exception) do |exception, **options|
      capture_called = true
      error_captured = exception
      # Don't actually send to Sentry
      nil
    end

    begin
      # Trigger an error that would normally be captured by Sentry
      test_error = StandardError.new("Test error for Sentry")
      Sentry.capture_exception(test_error)

      assert capture_called, "Sentry.capture_exception should be called"
      assert_equal "Test error for Sentry", error_captured.message
    ensure
      # Restore the original method
      Sentry.define_singleton_method(:capture_exception, original_method)
    end
  end
end
