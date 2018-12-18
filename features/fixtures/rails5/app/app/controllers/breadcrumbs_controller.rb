class BreadcrumbsController < ActionController::Base
  protect_from_forgery with: :exception

  def initialize
    @cache = ActiveSupport::Cache::MemoryStore.new
  end

  def handled
    Bugsnag.notify("Request breadcrumb")
    render json: {}
  end

  def sql_breadcrumb
    User.take
    Bugsnag.notify("SQL breadcrumb")
    render json: {}
  end

  def active_job
    ApplicationJob.perform_later
    render json: {}
  end

  def cache_read
    @cache.write('test', true)
    @cache.read('test')
    Bugsnag.notify("Cache breadcrumb")
    render json: {}
  end

  def action_mailer
    Bugsnag.notify("Mailer breadcrumb")
    render json: {}
  end
end
