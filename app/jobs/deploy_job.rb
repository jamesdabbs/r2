class DeployJob < ActiveJob::Base
  # TODO: Rollbar monitoring

  def perform user:, url:
    Deployer.new(
      user:        user,
      url:         url,
      working_dir: Rails.root.join("tmp", "dist")
    ).run
  end
end
