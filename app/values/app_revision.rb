require 'forwardable'
require 'singleton'

class AppRevision
  include Singleton

  class << self
    extend Forwardable
    def_delegators :instance, :sha, :log, :deployer, :release_number, :branch, :to_h
  end

  def sha
    @sha ||= print_file(Rails.root.join('REVISION'))
  end

  def log
    @log ||= print_file(Rails.root.join('..', '..', 'revisions.log'), "|grep #{sha}|tail -n 1")
  end

  def deployer
    @deployer ||= log.to_s.scan(/[0-9]+ by (.+)/).first&.first
  end

  def release_number
    @release_number ||= log.to_s.scan(/release ([0-9]+) by /).first&.first
  end

  def branch
    @branch ||= log.to_s.scan(/Branch (.+) \(at/).first&.first
  end

  def to_h
    {
      sha: sha,
      branch: branch,
      deployer: deployer,
      release_number: release_number
    }.with_indifferent_access
  end

  private

  def print_file(file_path, postfix = nil)
    return nil unless File.exist?(file_path)
    `cat #{file_path} #{postfix}`.to_s.force_encoding('UTF-8').tr("\n", '')
  end

  def file_exists?(*paths)
    File.exist?(file_path(*paths))
  end

  def file_path(*paths)
    Rails.root.join(*paths)
  end
end
