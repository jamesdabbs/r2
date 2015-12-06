class Deployer
  attr_reader :url, :work_dir

  def initialize url:, work_dir:
    @url, @work_dir = url, work_dir
  end

  def run
    # FIXME: this just needs to run in Sidekiq so that it doesn't block the web process
    #   that it's trying to call out to
    Thread.new do
      pull_repo
      write_preview
      commit
      push
      notify
    end
  end

  private

  def pull_repo
    # FIXME: this needs to actually pull stuff and not be a shell injection
    `mkdir -p #{work_dir} && cd #{work_dir} && git init`
  end

  def write_preview
    dest = work_dir.join "index.html"
    File.write dest, preview
  end

  def commit
    # FIXME: similarly, this needs not to be a shell injection
    `cd #{work_dir} && git add -A . && git commit -m "Deploy"`
  end

  def push
    # TODO: implement
  end

  def notify
    # TODO: send notification to Slack
  end

  def preview
    @_preview ||= Nokogiri::HTML(Net::HTTP.get URI url).tap do |doc|
      doc.css(".preview-only").remove
    end
  end
end
