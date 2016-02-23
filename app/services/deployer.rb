class Deployer
  class Error < StandardError; end

  attr_reader :user, :url, :working_dir

  def initialize user:, url:, working_dir:
    @user, @url, @working_dir = user, url, working_dir
  end

  def run
    sha = commit_changes
    push
    notify sha
  end

  private


  def credentials
    @_credentials ||= Rugged::Credentials::UserPassword.new \
      username: Figaro.env.DEPLOY_USERNAME!,
      password: Figaro.env.DEPLOY_PASSWORD!
  end

  def repo
    @_repo ||= if Dir.exists?(working_dir)
      Rugged::Repository.new working_dir.to_s
    else
      Rugged::Repository.clone_at \
        "https://github.com/15th-and-p/15th-and-p.github.io.git",
        working_dir.to_s,
        credentials: credentials
    end
  end

  def commit_changes
    oid = repo.write preview.to_s, :blob
    repo.index.read_tree repo.head.target.tree
    repo.index.add path: "index.html", oid: oid, mode: 0100644
    tree    = repo.index.write_tree repo
    parents = repo.empty? ? [] : [ repo.head.target ].compact

    Rugged::Commit.create repo,
      tree:       tree,
      parents:    parents,
      update_ref: "HEAD",
      message:    "Deploy",
      author: {
        email: user.email,
        name:  user.name,
        time:  Time.now
      },
      committer: {
        email: "jamesdabbs+15pdeployer@gmail.com",
        name:  "Deployer",
        time:  Time.now
      }
  end

  def push
    repo.push "origin", ["refs/heads/master"], credentials: credentials
  end

  def notify sha
    link   = "https://github.com/15th-and-p/15th-and-p.github.io/commit/#{sha}"
    author = "#{user.name} <#{user.email}>"

    Slack.new.notify \
      text: "Changes pushed",
      attachments: [
        {
          fields: [
            { title: "Commit", value: "<#{link}|#{sha}>", short: true },
            { title: "By", value: author, short: true }
          ],
          fallback: "Commit #{sha} (#{link}) by #{author}"
        }
      ]
  end

  def preview
    @_preview ||= Nokogiri::HTML(Net::HTTP.get URI url).tap do |doc|
      doc.css(".preview-only").remove
    end
  rescue Errno::ECONNREFUSED
    raise Error.new("Could not connect to `#{url}`")
  end
end
