class DeployJob < ActiveJob::Base
  # TODO: Rollbar monitoring

  def perform url
    Deployer.new(
      url:      url,
      work_dir: Rails.root.join("tmp", "dst")
    ).run
  end
end
