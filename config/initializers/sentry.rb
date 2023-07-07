Sentry.init do |config|
  config.dsn = 'https://104d327c411f4402806f0b0fb6191efd@o4505487998058496.ingest.sentry.io/4505488010051584'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
